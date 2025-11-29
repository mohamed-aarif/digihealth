using System;
using System.Threading.Tasks;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Localization;
using IdentityService.Permissions;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.FamilyLinks;

[Authorize(IdentityServicePermissions.FamilyLinks.Default)]
public class FamilyLinkAppService : CrudAppService<FamilyLink, FamilyLinkDto, Guid, PagedAndSortedResultRequestDto, CreateFamilyLinkDto, UpdateFamilyLinkDto>,
    IFamilyLinkAppService
{
    public FamilyLinkAppService(IRepository<FamilyLink, Guid> repository)
        : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task<FamilyLinkDto> CreateAsync(CreateFamilyLinkDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task<FamilyLinkDto> UpdateAsync(Guid id, UpdateFamilyLinkDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override FamilyLink MapToEntity(CreateFamilyLinkDto createInput)
    {
        return new FamilyLink(
            GuidGenerator.Create(),
            createInput.TenantId ?? CurrentTenant.Id,
            createInput.PatientId,
            createInput.FamilyUserId,
            createInput.Relationship,
            createInput.IsGuardian);
    }

    protected override void MapToEntity(UpdateFamilyLinkDto updateInput, FamilyLink entity)
    {
        entity.Update(
            updateInput.PatientId,
            updateInput.FamilyUserId,
            updateInput.Relationship,
            updateInput.IsGuardian);
        entity.ChangeTenant(updateInput.TenantId ?? CurrentTenant.Id);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }
}
