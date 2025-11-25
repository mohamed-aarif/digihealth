using System;
using System.Threading.Tasks;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp;

namespace PatientService.PatientMedicalSummaries;

public class PatientMedicalSummaryAppService : CrudAppService<
    PatientMedicalSummary,
    PatientMedicalSummaryDto,
    Guid,
    PagedAndSortedResultRequestDto,
    CreateUpdatePatientMedicalSummaryDto,
    CreateUpdatePatientMedicalSummaryDto>, IPatientMedicalSummaryAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public PatientMedicalSummaryAppService(
        IRepository<PatientMedicalSummary, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = PatientServicePermissions.PatientMedicalSummaries.Default;
        GetListPolicyName = PatientServicePermissions.PatientMedicalSummaries.Default;
        CreatePolicyName = PatientServicePermissions.PatientMedicalSummaries.Create;
        UpdatePolicyName = PatientServicePermissions.PatientMedicalSummaries.Update;
        DeletePolicyName = PatientServicePermissions.PatientMedicalSummaries.Delete;
    }

    public async Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : await MapToGetOutputDtoAsync(entity);
    }

    protected override async Task<PatientMedicalSummary> MapToEntityAsync(CreateUpdatePatientMedicalSummaryDto createInput)
    {
        await EnsureIdentityPatientExistsAsync(createInput.IdentityPatientId);
        return await base.MapToEntityAsync(createInput);
    }

    protected override async Task MapToEntityAsync(CreateUpdatePatientMedicalSummaryDto updateInput, PatientMedicalSummary entity)
    {
        await EnsureIdentityPatientExistsAsync(updateInput.IdentityPatientId);
        await base.MapToEntityAsync(updateInput, entity);
        entity.IdentityPatientId = updateInput.IdentityPatientId;
        entity.UpdateDetails(updateInput.BloodGroup, updateInput.Allergies, updateInput.ChronicConditions, updateInput.Notes);
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
