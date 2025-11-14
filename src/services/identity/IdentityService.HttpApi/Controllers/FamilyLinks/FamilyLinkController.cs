using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.FamilyLinks;
using IdentityService.FamilyLinks.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

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
    public async Task<ActionResult<FamilyLinkDto>> GetAsync(Guid id)
    {
        try
        {
            return await _familyLinkAppService.GetAsync(id);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpPost]
    public Task<FamilyLinkDto> CreateAsync([FromBody] CreateUpdateFamilyLinkDto input)
    {
        return _familyLinkAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<FamilyLinkDto>> UpdateAsync(Guid id, [FromBody] CreateUpdateFamilyLinkDto input)
    {
        try
        {
            return await _familyLinkAppService.UpdateAsync(id, input);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteAsync(Guid id)
    {
        try
        {
            await _familyLinkAppService.DeleteAsync(id);
            return NoContent();
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }
}
