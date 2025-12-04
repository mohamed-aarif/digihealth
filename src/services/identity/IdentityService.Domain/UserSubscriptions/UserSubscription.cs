using System;
using System.ComponentModel.DataAnnotations.Schema;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.UserSubscriptions;

[Table("user_subscriptions", Schema = "identity")]
public class UserSubscription : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public Guid UserId { get; private set; }
    public Guid SubscriptionPlanId { get; private set; }
    public DateTime StartDate { get; private set; }
    public DateTime? EndDate { get; private set; }
    public bool AutoRenew { get; private set; }
    public string Status { get; private set; } = null!;
    public string? ExternalReference { get; private set; }
    public string? PaymentGateway { get; private set; }
    public string? MetadataJson { get; private set; }
    public DateTime? CancelledAt { get; private set; }

    protected UserSubscription()
    {
        this.SetDefaultsForExtraProperties();
    }

    public UserSubscription(
        Guid id,
        Guid? tenantId,
        Guid userId,
        Guid subscriptionPlanId,
        DateTime startDate,
        DateTime? endDate,
        bool autoRenew,
        string status,
        string? externalReference,
        string? paymentGateway,
        string? metadataJson,
        DateTime? cancelledAt) : base(id)
    {
        TenantId = tenantId;
        SetUserId(userId);
        SetSubscriptionPlanId(subscriptionPlanId);
        UpdateSubscription(startDate, endDate, autoRenew, status, externalReference, paymentGateway, metadataJson, cancelledAt);
        this.SetDefaultsForExtraProperties();
    }

    public void UpdateSubscription(
        DateTime startDate,
        DateTime? endDate,
        bool autoRenew,
        string status,
        string? externalReference,
        string? paymentGateway,
        string? metadataJson,
        DateTime? cancelledAt)
    {
        StartDate = startDate;
        EndDate = endDate;
        AutoRenew = autoRenew;
        Status = Check.Length(Check.NotNullOrWhiteSpace(status, nameof(status)), nameof(status), UserSubscriptionConsts.MaxStatusLength);
        ExternalReference = externalReference.IsNullOrWhiteSpace()
            ? null
            : Check.Length(externalReference, nameof(externalReference), UserSubscriptionConsts.MaxExternalReferenceLength);
        PaymentGateway = paymentGateway.IsNullOrWhiteSpace()
            ? null
            : Check.Length(paymentGateway, nameof(paymentGateway), UserSubscriptionConsts.MaxPaymentGatewayLength);
        MetadataJson = metadataJson;
        CancelledAt = cancelledAt;
    }

    public void ChangeSubscriptionPlan(Guid newPlanId)
    {
        SetSubscriptionPlanId(newPlanId);
    }

    public void Cancel(DateTime cancelledAtUtc, string status, DateTime? endDate)
    {
        CancelledAt = cancelledAtUtc;
        EndDate = endDate;
        Status = Check.Length(Check.NotNullOrWhiteSpace(status, nameof(status)), nameof(status), UserSubscriptionConsts.MaxStatusLength);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetUserId(Guid userId)
    {
        UserId = Check.NotNull(userId, nameof(userId));
    }

    private void SetSubscriptionPlanId(Guid subscriptionPlanId)
    {
        SubscriptionPlanId = Check.NotNull(subscriptionPlanId, nameof(subscriptionPlanId));
    }
}
