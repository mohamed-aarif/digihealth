using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Users;
using IdentityService.Users.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

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
    public Task<IdentityUserAccountDto> GetAsync(Guid id)
    {
        return _identityUserAccountAppService.GetAsync(id);
    }

    [HttpPost]
    public Task<IdentityUserAccountDto> CreateAsync([FromBody] CreateUpdateIdentityUserAccountDto input)
    {
        return _identityUserAccountAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<IdentityUserAccountDto> UpdateAsync(Guid id, [FromBody] CreateUpdateIdentityUserAccountDto input)
    {
        return _identityUserAccountAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _identityUserAccountAppService.DeleteAsync(id);
    }
}
