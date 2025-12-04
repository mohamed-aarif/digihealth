using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.SubscriptionPlans.Dtos;

public class SubscriptionPlanDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public string Code { get; set; } = null!;
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string BillingPeriod { get; set; } = null!;
    public decimal PriceAmount { get; set; }
    public string PriceCurrency { get; set; } = null!;
    public bool IsFree { get; set; }
    public bool IsActive { get; set; }
    public int SortOrder { get; set; }
    public int? MaxDevices { get; set; }
    public int? MaxVaultRecords { get; set; }
    public int? MaxAiMessagesPerMonth { get; set; }
    public string? MetadataJson { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
