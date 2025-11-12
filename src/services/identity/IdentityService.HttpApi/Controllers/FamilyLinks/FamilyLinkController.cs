using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.FamilyLinks;
using IdentityService.FamilyLinks.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Controllers.FamilyLinks;

[Route("api/identity/family-links")]
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
    public Task<FamilyLinkDto> CreateAsync([FromBody] CreateUpdateFamilyLinkDto input)
    {
        return _familyLinkAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<FamilyLinkDto> UpdateAsync(Guid id, [FromBody] CreateUpdateFamilyLinkDto input)
    {
        return _familyLinkAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _familyLinkAppService.DeleteAsync(id);
    }
}
