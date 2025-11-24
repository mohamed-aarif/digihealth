using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Dtos.ExternalLinks;
using PatientService.Entities;
using PatientService.Identity;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Authorization;

namespace PatientService.ExternalLinks;

[Authorize(PatientServicePermissions.PatientExternalLinks.Default)]
public class PatientExternalLinkAppService : CrudAppService<
    PatientExternalLink,
    PatientExternalLinkDto,
    Guid,
    PagedAndSortedResultRequestDto,
    CreateUpdatePatientExternalLinkDto>, IPatientExternalLinkAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public PatientExternalLinkAppService(
        IRepository<PatientExternalLink, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = PatientServicePermissions.PatientExternalLinks.Default;
        GetListPolicyName = PatientServicePermissions.PatientExternalLinks.Default;
        CreatePolicyName = PatientServicePermissions.PatientExternalLinks.Manage;
        UpdatePolicyName = PatientServicePermissions.PatientExternalLinks.Manage;
        DeletePolicyName = PatientServicePermissions.PatientExternalLinks.Manage;
    }

    public async Task<PagedResultDto<PatientExternalLinkDto>> GetListAsync(Guid identityPatientId, string? systemName)
    {
        var query = Repository.AsQueryable().Where(x => x.IdentityPatientId == identityPatientId);
        if (!string.IsNullOrWhiteSpace(systemName))
        {
            query = query.Where(x => x.SystemName == systemName);
        }

        var totalCount = await AsyncExecuter.CountAsync(query);
        var items = await AsyncExecuter.ToListAsync(query);
        return new PagedResultDto<PatientExternalLinkDto>(totalCount, items.Select(MapToGetOutputDto).ToList());
    }

    public override async Task<PatientExternalLinkDto> CreateAsync(CreateUpdatePatientExternalLinkDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    public override async Task<PatientExternalLinkDto> UpdateAsync(Guid id, CreateUpdatePatientExternalLinkDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    protected override IQueryable<PatientExternalLink> CreateFilteredQuery(PagedAndSortedResultRequestDto input)
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
