using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Authorization;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Linq;

namespace PatientService.Patients;

[Authorize(PatientServicePermissions.PatientProfiles.Default)]
public class PatientProfileAppService :
    CrudAppService<
        PatientProfileExtension,
        PatientProfileExtensionDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientProfileExtensionDto>,
    IPatientProfileAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookup;

    public PatientProfileAppService(
        IRepository<PatientProfileExtension, Guid> repository,
        IPatientIdentityLookupAppService identityLookup) : base(repository)
    {
        _identityLookup = identityLookup;
        GetPolicyName = PatientServicePermissions.PatientProfiles.Default;
        CreatePolicyName = PatientServicePermissions.PatientProfiles.Create;
        UpdatePolicyName = PatientServicePermissions.PatientProfiles.Update;
        DeletePolicyName = PatientServicePermissions.PatientProfiles.Delete;
    }

    public override async Task<PatientProfileExtensionDto> CreateAsync(CreateUpdatePatientProfileExtensionDto input)
    {
        await ValidateIdentityPatientAsync(input.IdentityPatientId);
        return await base.CreateAsync(input);
    }

    public override async Task<PatientProfileExtensionDto> UpdateAsync(Guid id, CreateUpdatePatientProfileExtensionDto input)
    {
        await ValidateIdentityPatientAsync(input.IdentityPatientId);
        return await base.UpdateAsync(id, input);
    }

    public async Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var entity = await Repository.FirstOrDefaultAsync(x => x.IdentityPatientId == identityPatientId);
        return entity == null ? null : MapToGetOutputDto(entity);
    }

    protected override Task<IQueryable<PatientProfileExtension>> CreateFilteredQueryAsync(PagedAndSortedResultRequestDto input)
    {
        return Task.FromResult(Repository.WhereIf(!string.IsNullOrWhiteSpace(input.Filter),
            x => (x.PrimaryContactNumber != null && x.PrimaryContactNumber.Contains(input.Filter!)) ||
                 (x.Email != null && x.Email.Contains(input.Filter!))));
    }

    private async Task ValidateIdentityPatientAsync(Guid identityPatientId)
    {
        if (!await _identityLookup.IdentityPatientExistsAsync(identityPatientId))
        {
            throw new AbpAuthorizationException($"Identity patient '{identityPatientId}' is not recognized.");
        }
    }
}
