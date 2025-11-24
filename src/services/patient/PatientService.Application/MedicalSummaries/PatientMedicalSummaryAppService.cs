using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Identity;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace PatientService.MedicalSummaries;

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
    }

    [Authorize(PatientServicePermissions.MedicalSummaries.Manage)]
    public override async Task<PatientMedicalSummaryDto> CreateAsync(CreateUpdatePatientMedicalSummaryDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        await EnsureNoDuplicateAsync(input.IdentityPatientId, null);
        return await base.CreateAsync(input);
    }

    [Authorize(PatientServicePermissions.MedicalSummaries.Manage)]
    public override async Task<PatientMedicalSummaryDto> UpdateAsync(Guid id, CreateUpdatePatientMedicalSummaryDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        await EnsureNoDuplicateAsync(input.IdentityPatientId, id);
        return await base.UpdateAsync(id, input);
    }

    [Authorize(PatientServicePermissions.MedicalSummaries.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public async Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var queryable = await Repository.GetQueryableAsync();
        var entity = await AsyncExecuter.FirstOrDefaultAsync(queryable.Where(x => x.IdentityPatientId == identityPatientId));
        return entity == null ? null : ObjectMapper.Map<PatientMedicalSummary, PatientMedicalSummaryDto>(entity);
    }

    protected override IQueryable<PatientMedicalSummary> ApplySorting(IQueryable<PatientMedicalSummary> query, PagedAndSortedResultRequestDto input)
    {
        return query.OrderByDescending(x => x.Id);
    }

    private async Task EnsureIdentityPatientIsValidAsync(Guid identityPatientId)
    {
        if (!await _identityLookup.ExistsAsync(identityPatientId))
        {
            throw new BusinessException(PatientServiceErrorCodes.IdentityPatientNotFound)
                .WithData(nameof(identityPatientId), identityPatientId);
        }
    }

    private async Task EnsureNoDuplicateAsync(Guid identityPatientId, Guid? currentEntityId)
    {
        var queryable = await Repository.GetQueryableAsync();
        var exists = await AsyncExecuter.AnyAsync(
            queryable.Where(x => x.IdentityPatientId == identityPatientId && (!currentEntityId.HasValue || x.Id != currentEntityId.Value)));

        if (exists)
        {
            throw new BusinessException(PatientServiceErrorCodes.DuplicateIdentityPatient)
                .WithData(nameof(identityPatientId), identityPatientId);
        }
    }
}
