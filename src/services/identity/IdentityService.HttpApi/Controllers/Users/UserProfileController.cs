using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Permissions;
using IdentityService.Users;
using IdentityService.Users.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Controllers.Users;

[Authorize(IdentityServicePermissions.Profile.Default)]
[Route("api/identity-service/user-profiles")]
public class UserProfileController : IdentityServiceController
{
    private readonly IUserProfileAppService _userProfileAppService;

    public UserProfileController(IUserProfileAppService userProfileAppService)
    {
        _userProfileAppService = userProfileAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<UserProfileDto>> GetListAsync([FromQuery] UserProfilePagedAndSortedResultRequestDto input)
    {
        return _userProfileAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<UserProfileDto> GetAsync(Guid id)
    {
        return _userProfileAppService.GetAsync(id);
    }

    [HttpPost]
    public Task<UserProfileDto> CreateAsync([FromBody] CreateUserProfileDto input)
    {
        return _userProfileAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<UserProfileDto> UpdateAsync(Guid id, [FromBody] UpdateUserProfileDto input)
    {
        return _userProfileAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _userProfileAppService.DeleteAsync(id);
    }
}
