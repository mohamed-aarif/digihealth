using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.UserSubscriptions.Dtos;

public class UserSubscriptionPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? TenantId { get; set; }
    public Guid? UserId { get; set; }
    public Guid? SubscriptionPlanId { get; set; }
    public string? Status { get; set; }
}
