using System;
using System.Threading.Tasks;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp;

namespace PatientService.PatientProfiles;

public class PatientProfileAppService : CrudAppService<
    PatientProfileExtension,
    PatientProfileExtensionDto,
    Guid,
    PagedAndSortedResultRequestDto,
    CreateUpdatePatientProfileExtensionDto,
    CreateUpdatePatientProfileExtensionDto>, IPatientProfileAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public PatientProfileAppService(
        IRepository<PatientProfileExtension, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = PatientServicePermissions.PatientProfiles.Default;
        GetListPolicyName = PatientServicePermissions.PatientProfiles.Default;
        CreatePolicyName = PatientServicePermissions.PatientProfiles.Create;
        UpdatePolicyName = PatientServicePermissions.PatientProfiles.Update;
        DeletePolicyName = PatientServicePermissions.PatientProfiles.Delete;
    }

    public async Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : await MapToGetOutputDtoAsync(entity);
    }

    protected override async Task<PatientProfileExtension> MapToEntityAsync(CreateUpdatePatientProfileExtensionDto createInput)
    {
        await EnsureIdentityPatientExistsAsync(createInput.IdentityPatientId);
        return await base.MapToEntityAsync(createInput);
    }

    protected override async Task MapToEntityAsync(CreateUpdatePatientProfileExtensionDto updateInput, PatientProfileExtension entity)
    {
        await EnsureIdentityPatientExistsAsync(updateInput.IdentityPatientId);
        await base.MapToEntityAsync(updateInput, entity);
        entity.IdentityPatientId = updateInput.IdentityPatientId;
        entity.UpdateContact(updateInput.PrimaryContactNumber, updateInput.SecondaryContactNumber, updateInput.Email);
        entity.UpdateAddress(updateInput.AddressLine1, updateInput.AddressLine2, updateInput.City, updateInput.State, updateInput.ZipCode, updateInput.Country);
        entity.UpdateEmergencyContact(updateInput.EmergencyContactName, updateInput.EmergencyContactNumber);
        entity.UpdatePreferredLanguage(updateInput.PreferredLanguage);
    }

    private async Task EnsureIdentityPatientExistsAsync(Guid identityPatientId)
    {
        if (!await _identityLookupAppService.ValidatePatientIdAsync(identityPatientId))
        {
            throw new BusinessException("PatientService:IdentityPatientNotFound")
                .WithData("IdentityPatientId", identityPatientId);
        }
    }
}
