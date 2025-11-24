using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Dtos.MedicalSummaries;
using PatientService.Entities;
using PatientService.Identity;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Authorization;

namespace PatientService.MedicalSummaries;

[Authorize(PatientServicePermissions.PatientMedicalSummaries.Default)]
public class PatientMedicalSummaryAppService : CrudAppService<
    PatientMedicalSummary,
    PatientMedicalSummaryDto,
    Guid,
    PagedAndSortedResultRequestDto,
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
        CreatePolicyName = PatientServicePermissions.PatientMedicalSummaries.Manage;
        UpdatePolicyName = PatientServicePermissions.PatientMedicalSummaries.Manage;
        DeletePolicyName = PatientServicePermissions.PatientMedicalSummaries.Manage;
    }

    public async Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : MapToGetOutputDto(entity);
    }

    public override async Task<PatientMedicalSummaryDto> CreateAsync(CreateUpdatePatientMedicalSummaryDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    public override async Task<PatientMedicalSummaryDto> UpdateAsync(Guid id, CreateUpdatePatientMedicalSummaryDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    protected override IQueryable<PatientMedicalSummary> CreateFilteredQuery(PagedAndSortedResultRequestDto input)
    {
        return Repository.AsQueryable();
    }

    private async Task EnsureIdentityPatientExistsAsync(Guid identityPatientId)
    {
        var exists = await _identityLookupAppService.ValidatePatientAsync(identityPatientId);
        if (!exists)
        {
            throw new AbpAuthorizationException("Identity patient not found or not accessible in IdentityService.");
        }
    }
}
