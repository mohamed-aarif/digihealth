using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace PatientService.Patients;

[Authorize(PatientServicePermissions.ExternalLinks.Default)]
public class PatientExternalLinkAppService :
    CrudAppService<
        PatientExternalLink,
        PatientExternalLinkDto,
        Guid,
        PatientExternalLinkPagedAndSortedResultRequestDto,
        CreateUpdatePatientExternalLinkDto>,
    IPatientExternalLinkAppService
{
    public PatientExternalLinkAppService(IRepository<PatientExternalLink, Guid> repository) : base(repository)
    {
        GetPolicyName = PatientServicePermissions.ExternalLinks.Default;
        CreatePolicyName = PatientServicePermissions.ExternalLinks.Create;
        UpdatePolicyName = PatientServicePermissions.ExternalLinks.Update;
        DeletePolicyName = PatientServicePermissions.ExternalLinks.Delete;
    }

    protected override Task<IQueryable<PatientExternalLink>> CreateFilteredQueryAsync(PatientExternalLinkPagedAndSortedResultRequestDto input)
    {
        var query = Repository.WhereIf(input.IdentityPatientId.HasValue, x => x.IdentityPatientId == input.IdentityPatientId.Value)
            .WhereIf(!string.IsNullOrWhiteSpace(input.SystemName), x => x.SystemName == input.SystemName);

        return Task.FromResult(query);
    }
}
