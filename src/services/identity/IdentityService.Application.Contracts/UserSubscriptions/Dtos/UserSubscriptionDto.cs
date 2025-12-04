using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.UserSubscriptions.Dtos;

public class UserSubscriptionDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public Guid UserId { get; set; }
    public Guid SubscriptionPlanId { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public bool AutoRenew { get; set; }
    public string Status { get; set; } = null!;
    public string? ExternalReference { get; set; }
    public string? PaymentGateway { get; set; }
    public string? MetadataJson { get; set; }
    public DateTime? CancelledAt { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
