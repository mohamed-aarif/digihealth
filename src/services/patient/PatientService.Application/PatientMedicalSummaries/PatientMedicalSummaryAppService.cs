using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace PatientService.PatientMedicalSummaries;

[Authorize(DigiHealthPatientPermissions.PatientMedicalSummaries.Default)]
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
        GetPolicyName = DigiHealthPatientPermissions.PatientMedicalSummaries.Default;
        GetListPolicyName = DigiHealthPatientPermissions.PatientMedicalSummaries.Default;
        CreatePolicyName = DigiHealthPatientPermissions.PatientMedicalSummaries.Create;
        UpdatePolicyName = DigiHealthPatientPermissions.PatientMedicalSummaries.Edit;
        DeletePolicyName = DigiHealthPatientPermissions.PatientMedicalSummaries.Delete;
    }

    public async Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : await MapToGetOutputDtoAsync(entity);
    }

    public async Task<PatientMedicalSummaryDto> CreateOrUpdateForPatientAsync(CreateUpdatePatientMedicalSummaryDto input)
    {
        var existing = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == input.IdentityPatientId);
        if (existing == null)
        {
            await CheckCreatePolicyAsync();
            return await CreateAsync(input);
        }

        await CheckUpdatePolicyAsync();
        await MapToEntityAsync(input, existing);
        await Repository.UpdateAsync(existing, autoSave: true);
        return await MapToGetOutputDtoAsync(existing);
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
        entity.SetIdentityPatientId(updateInput.IdentityPatientId);
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
