using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.FamilyLinks;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Permissions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Controllers.FamilyLinks;

[Authorize(IdentityServicePermissions.FamilyLinks.Default)]
[Route("api/identity-service/family-links")]
public class FamilyLinkController : IdentityServiceController
{
    private readonly IFamilyLinkAppService _familyLinkAppService;

    public FamilyLinkController(IFamilyLinkAppService familyLinkAppService)
    {
        _familyLinkAppService = familyLinkAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<FamilyLinkDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _familyLinkAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<FamilyLinkDto> GetAsync(Guid id)
    {
        return _familyLinkAppService.GetAsync(id);
    }

    [HttpPost]
    [Authorize(IdentityServicePermissions.FamilyLinks.Create)]
    public Task<FamilyLinkDto> CreateAsync(CreateFamilyLinkDto input)
    {
        return _familyLinkAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    [Authorize(IdentityServicePermissions.FamilyLinks.Edit)]
    public Task<FamilyLinkDto> UpdateAsync(Guid id, UpdateFamilyLinkDto input)
    {
        return _familyLinkAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    [Authorize(IdentityServicePermissions.FamilyLinks.Delete)]
    public Task DeleteAsync(Guid id)
    {
        return _familyLinkAppService.DeleteAsync(id);
    }
}
