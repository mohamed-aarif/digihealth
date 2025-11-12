using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Users.Dtos;

public class IdentityUserAccountDto : EntityDto<Guid>
{
    public string UserName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string UserType { get; set; } = string.Empty;
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
}
