using System;
using IdentityService.Users.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.Users;

public interface IUserProfileAppService :
    ICrudAppService<
        UserProfileDto,
        Guid,
        UserProfilePagedAndSortedResultRequestDto,
        CreateUserProfileDto,
        UpdateUserProfileDto>
{
}
