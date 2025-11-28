using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Users.Dtos;

public class UserProfilePagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? TenantId { get; set; }
    public string? Filter { get; set; }
    public bool? IsActive { get; set; }
}
