using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Dtos;

namespace IdentityService.SubscriptionPlans.Dtos;

public class CreateSubscriptionPlanDto : EntityDto<Guid>
{
    [Required]
    public string Code { get; set; } = null!;

    [Required]
    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    [Required]
    public string BillingPeriod { get; set; } = null!;

    [Required]
    public decimal PriceAmount { get; set; }

    [Required]
    public string PriceCurrency { get; set; } = null!;

    public bool IsFree { get; set; }

    public bool IsActive { get; set; } = true;

    public int SortOrder { get; set; }

    public int? MaxDevices { get; set; }

    public int? MaxVaultRecords { get; set; }

    public int? MaxAiMessagesPerMonth { get; set; }

    public string? MetadataJson { get; set; }
}
