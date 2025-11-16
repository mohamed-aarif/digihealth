using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Users;
using IdentityService.Users.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Controllers.Users;

[Route("api/identity/users")]
public class IdentityUserAccountController : IdentityServiceController
{
    private readonly IIdentityUserAccountAppService _identityUserAccountAppService;

    public IdentityUserAccountController(IIdentityUserAccountAppService identityUserAccountAppService)
    {
        _identityUserAccountAppService = identityUserAccountAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<IdentityUserAccountDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _identityUserAccountAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<IdentityUserAccountDto>> GetAsync(Guid id)
    {
        try
        {
            return await _identityUserAccountAppService.GetAsync(id);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpPost]
    public Task<IdentityUserAccountDto> CreateAsync([FromBody] CreateUpdateIdentityUserAccountDto input)
    {
        return _identityUserAccountAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<IdentityUserAccountDto>> UpdateAsync(Guid id, [FromBody] CreateUpdateIdentityUserAccountDto input)
    {
        try
        {
            return await _identityUserAccountAppService.UpdateAsync(id, input);
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
            await _identityUserAccountAppService.DeleteAsync(id);
            return NoContent();
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }
}
