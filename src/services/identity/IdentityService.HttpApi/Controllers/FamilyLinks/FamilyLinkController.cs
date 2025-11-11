using System;
using IdentityService.FamilyLinks;
using IdentityService.FamilyLinks.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.AspNetCore.Mvc;

namespace IdentityService.Controllers.FamilyLinks;

[Route("api/identity/family-links")]
public class FamilyLinkController : AbpCrudController<FamilyLink, FamilyLinkDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateFamilyLinkDto>
{
    public FamilyLinkController(IFamilyLinkAppService familyLinkAppService) : base(familyLinkAppService)
    {
    }
}
