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

namespace PatientService.PatientProfiles;

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
    }

    [Authorize(PatientServicePermissions.PatientProfiles.Manage)]
    public override async Task<PatientProfileExtensionDto> CreateAsync(CreateUpdatePatientProfileExtensionDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        await EnsureNoDuplicateAsync(input.IdentityPatientId, null);
        return await base.CreateAsync(input);
    }

    [Authorize(PatientServicePermissions.PatientProfiles.Manage)]
    public override async Task<PatientProfileExtensionDto> UpdateAsync(Guid id, CreateUpdatePatientProfileExtensionDto input)
    {
        await EnsureIdentityPatientIsValidAsync(input.IdentityPatientId);
        await EnsureNoDuplicateAsync(input.IdentityPatientId, id);
        return await base.UpdateAsync(id, input);
    }

    [Authorize(PatientServicePermissions.PatientProfiles.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public async Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        var queryable = await Repository.GetQueryableAsync();
        var entity = await AsyncExecuter.FirstOrDefaultAsync(
            queryable.Where(x => x.IdentityPatientId == identityPatientId));

        return entity == null ? null : ObjectMapper.Map<PatientProfileExtension, PatientProfileExtensionDto>(entity);
    }

    protected override IQueryable<PatientProfileExtension> ApplySorting(IQueryable<PatientProfileExtension> query, PagedAndSortedResultRequestDto input)
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
