using System;
using System.ComponentModel.DataAnnotations.Schema;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.SubscriptionPlans;

[Table("subscription_plans", Schema = "identity")]
public class SubscriptionPlan : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public string Code { get; private set; } = null!;
    public string Name { get; private set; } = null!;
    public string? Description { get; private set; }
    public string BillingPeriod { get; private set; } = null!;
    public decimal PriceAmount { get; private set; }
    public string PriceCurrency { get; private set; } = null!;
    public bool IsFree { get; private set; }
    public bool IsActive { get; private set; }
    public int SortOrder { get; private set; }
    public int? MaxDevices { get; private set; }
    public int? MaxVaultRecords { get; private set; }
    public int? MaxAiMessagesPerMonth { get; private set; }
    public string? MetadataJson { get; private set; }

    protected SubscriptionPlan()
    {
        this.SetDefaultsForExtraProperties();
    }

    public SubscriptionPlan(
        Guid id,
        Guid? tenantId,
        string code,
        string name,
        string? description,
        string billingPeriod,
        decimal priceAmount,
        string priceCurrency,
        bool isFree,
        bool isActive,
        int sortOrder,
        int? maxDevices,
        int? maxVaultRecords,
        int? maxAiMessagesPerMonth,
        string? metadataJson) : base(id)
    {
        TenantId = tenantId;
        UpdatePlan(code, name, description, billingPeriod, priceAmount, priceCurrency, isFree, isActive, sortOrder, maxDevices, maxVaultRecords, maxAiMessagesPerMonth, metadataJson);
        this.SetDefaultsForExtraProperties();
    }

    public void UpdatePlan(
        string code,
        string name,
        string? description,
        string billingPeriod,
        decimal priceAmount,
        string priceCurrency,
        bool isFree,
        bool isActive,
        int sortOrder,
        int? maxDevices,
        int? maxVaultRecords,
        int? maxAiMessagesPerMonth,
        string? metadataJson)
    {
        Code = Check.Length(Check.NotNullOrWhiteSpace(code, nameof(code)), nameof(code), SubscriptionPlanConsts.MaxCodeLength)!;
        Name = Check.Length(Check.NotNullOrWhiteSpace(name, nameof(name)), nameof(name), SubscriptionPlanConsts.MaxNameLength)!;
        Description = description;
        BillingPeriod = Check.Length(Check.NotNullOrWhiteSpace(billingPeriod, nameof(billingPeriod)), nameof(billingPeriod), SubscriptionPlanConsts.MaxBillingPeriodLength)!;
        PriceAmount = priceAmount;
        PriceCurrency = Check.Length(Check.NotNullOrWhiteSpace(priceCurrency, nameof(priceCurrency)), nameof(priceCurrency), SubscriptionPlanConsts.MaxPriceCurrencyLength)!;
        IsFree = isFree;
        IsActive = isActive;
        SortOrder = sortOrder;
        MaxDevices = maxDevices;
        MaxVaultRecords = maxVaultRecords;
        MaxAiMessagesPerMonth = maxAiMessagesPerMonth;
        MetadataJson = metadataJson;
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }
}
