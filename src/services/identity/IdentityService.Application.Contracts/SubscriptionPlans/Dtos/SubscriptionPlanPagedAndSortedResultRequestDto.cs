using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.SubscriptionPlans.Dtos;

public class SubscriptionPlanPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? TenantId { get; set; }
    public bool? IsActive { get; set; }
}
