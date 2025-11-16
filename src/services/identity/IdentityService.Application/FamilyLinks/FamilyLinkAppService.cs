using System;
using IdentityService.FamilyLinks.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.FamilyLinks;

public class FamilyLinkAppService : CrudAppService<FamilyLink, FamilyLinkDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateFamilyLinkDto>, IFamilyLinkAppService
{
    public FamilyLinkAppService(IRepository<FamilyLink, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override FamilyLink MapToEntity(CreateUpdateFamilyLinkDto createInput)
    {
        return new FamilyLink(
            GuidGenerator.Create(),
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
