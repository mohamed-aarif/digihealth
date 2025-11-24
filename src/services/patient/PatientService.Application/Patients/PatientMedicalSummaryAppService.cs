using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Authorization;
using Volo.Abp.Domain.Repositories;

namespace PatientService.Patients;

[Authorize(PatientServicePermissions.MedicalSummaries.Default)]
public class PatientMedicalSummaryAppService :
    CrudAppService<
        PatientMedicalSummary,
        PatientMedicalSummaryDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientMedicalSummaryDto>,
    IPatientMedicalSummaryAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookup;

    public PatientMedicalSummaryAppService(
        IRepository<PatientMedicalSummary, Guid> repository,
        IPatientIdentityLookupAppService identityLookup) : base(repository)
    {
        _identityLookup = identityLookup;
        GetPolicyName = PatientServicePermissions.MedicalSummaries.Default;
        CreatePolicyName = PatientServicePermissions.MedicalSummaries.Create;
        UpdatePolicyName = PatientServicePermissions.MedicalSummaries.Update;
        DeletePolicyName = PatientServicePermissions.MedicalSummaries.Delete;
    }

    public override async Task<PatientMedicalSummaryDto> CreateAsync(CreateUpdatePatientMedicalSummaryDto input)
    {
        await ValidateIdentityPatientAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    public override async Task<PatientMedicalSummaryDto> UpdateAsync(Guid id, CreateUpdatePatientMedicalSummaryDto input)
    {
        await ValidateIdentityPatientAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    public async Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : MapToGetOutputDto(entity);
    }

    protected override Task<IQueryable<PatientMedicalSummary>> CreateFilteredQueryAsync(PagedAndSortedResultRequestDto input)
    {
        return Task.FromResult(Repository.WhereIf(!string.IsNullOrWhiteSpace(input.Filter),
            x => (x.Allergies != null && x.Allergies.Contains(input.Filter!)) ||
                 (x.ChronicConditions != null && x.ChronicConditions.Contains(input.Filter!)) ||
                 (x.Notes != null && x.Notes.Contains(input.Filter!))));
    }

    private async Task ValidateIdentityPatientAsync(Guid identityPatientId)
    {
        if (!await _identityLookup.IdentityPatientExistsAsync(identityPatientId))
        {
            throw new AbpAuthorizationException($"Identity patient '{identityPatientId}' is not recognized.");
        }
    }
}
