using System;
using IdentityService.Users.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.Users;

public interface IIdentityUserAccountAppService :
    ICrudAppService<
        IdentityUserAccountDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdateIdentityUserAccountDto>
{
}
