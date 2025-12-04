using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Dtos;

namespace IdentityService.UserSubscriptions.Dtos;

public class UpdateUserSubscriptionDto : EntityDto<Guid>
{
    [Required]
    public Guid UserId { get; set; }

    [Required]
    public Guid SubscriptionPlanId { get; set; }

    [Required]
    public DateTime StartDate { get; set; }

    public DateTime? EndDate { get; set; }

    public bool AutoRenew { get; set; }

    [Required]
    public string Status { get; set; } = null!;

    public string? ExternalReference { get; set; }

    public string? PaymentGateway { get; set; }

    public string? MetadataJson { get; set; }

    public DateTime? CancelledAt { get; set; }

    public string? ConcurrencyStamp { get; set; }
}
