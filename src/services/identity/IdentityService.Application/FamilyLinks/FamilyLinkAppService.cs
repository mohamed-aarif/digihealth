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
public class FamilyLinkAppService : CrudAppService<FamilyLink, FamilyLinkDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateFamilyLinkDto>,
    IFamilyLinkAppService
{
    public FamilyLinkAppService(IRepository<FamilyLink, Guid> repository)
        : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task<FamilyLinkDto> CreateAsync(CreateUpdateFamilyLinkDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task<FamilyLinkDto> UpdateAsync(Guid id, CreateUpdateFamilyLinkDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(IdentityServicePermissions.FamilyLinks.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override FamilyLink MapToEntity(CreateUpdateFamilyLinkDto createInput)
    {
        return new FamilyLink(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.PatientId,
            createInput.FamilyUserId,
            createInput.Relationship,
            createInput.IsGuardian);
    }

    protected override void MapToEntity(CreateUpdateFamilyLinkDto updateInput, FamilyLink entity)
    {
        entity.Update(
            updateInput.PatientId,
            updateInput.FamilyUserId,
            updateInput.Relationship,
            updateInput.IsGuardian);
    }
}
