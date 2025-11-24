using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Identity;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Linq;

namespace PatientService.ExternalLinks;

[Authorize(PatientServicePermissions.ExternalLinks.Default)]
public class PatientExternalLinkAppService :
    CrudAppService<
        PatientExternalLink,
        PatientExternalLinkDto,
        Guid,
        PatientExternalLinkGetListInput,
        CreateUpdatePatientExternalLinkDto>,
    IPatientExternalLinkAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookup;

    public PatientExternalLinkAppService(
        IRepository<PatientExternalLink, Guid> repository,
        IPatientIdentityLookupAppService identityLookup) : base(repository)
    {
        _identityLookup = identityLookup;
    }

    [Authorize(PatientServicePermissions.ExternalLinks.Manage)]
    public override async Task<PatientExternalLinkDto> CreateAsync(CreateUpdatePatientExternalLinkDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    [Authorize(PatientServicePermissions.ExternalLinks.Manage)]
    public override async Task<PatientExternalLinkDto> UpdateAsync(Guid id, CreateUpdatePatientExternalLinkDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    [Authorize(PatientServicePermissions.ExternalLinks.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<PatientExternalLink> CreateFilteredQuery(PatientExternalLinkGetListInput input)
    {
        var query = Repository.AsQueryable()
            .WhereIf(input.IdentityPatientId.HasValue, x => x.IdentityPatientId == input.IdentityPatientId)
            .WhereIf(!input.SystemName.IsNullOrWhiteSpace(), x => x.SystemName == input.SystemName);

        return query.OrderBy(x => x.SystemName).ThenBy(x => x.IdentityPatientId);
    }

    private async Task EnsureIdentityPatientIsValidAsync(Guid identityPatientId)
    {
        if (!await _identityLookup.ExistsAsync(identityPatientId))
        {
            throw new BusinessException(PatientServiceErrorCodes.IdentityPatientNotFound)
                .WithData(nameof(identityPatientId), identityPatientId);
        }
    }
}
