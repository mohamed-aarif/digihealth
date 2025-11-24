using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Dtos.Profiles;
using PatientService.Entities;
using PatientService.Identity;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Authorization;

namespace PatientService.Profiles;

[Authorize(PatientServicePermissions.PatientProfiles.Default)]
public class PatientProfileAppService : CrudAppService<
    PatientProfileExtension,
    PatientProfileExtensionDto,
    Guid,
    PagedAndSortedResultRequestDto,
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
        CreatePolicyName = PatientServicePermissions.PatientProfiles.Manage;
        UpdatePolicyName = PatientServicePermissions.PatientProfiles.Manage;
        DeletePolicyName = PatientServicePermissions.PatientProfiles.Manage;
    }

    public async Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : MapToGetOutputDto(entity);
    }

    public override async Task<PatientProfileExtensionDto> CreateAsync(CreateUpdatePatientProfileExtensionDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    public override async Task<PatientProfileExtensionDto> UpdateAsync(Guid id, CreateUpdatePatientProfileExtensionDto input)
    {
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    protected override IQueryable<PatientProfileExtension> CreateFilteredQuery(PagedAndSortedResultRequestDto input)
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
