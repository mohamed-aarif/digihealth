using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class TenantChatWidgetChannelConfig : Entity<Guid>, IMultiTenant
{
    public Guid TenantChatWidgetConfigId { get; protected set; }

    public Guid? TenantId { get; protected set; }

    public string ChannelId { get; protected set; }

    public bool IsEnabled { get; protected set; }

    public string? DomainsAllowedJson { get; protected set; }

    public string? ConfigJson { get; protected set; }

    public int ConfigVersion { get; protected set; }

    public TenantChatWidgetConfig TenantConfig { get; protected set; }

    protected TenantChatWidgetChannelConfig()
    {
        ChannelId = null!;
        TenantConfig = null!;
        IsEnabled = true;
        DomainsAllowedJson = "[]";
        ConfigJson = "{}";
        ConfigVersion = 1;
    }

    public TenantChatWidgetChannelConfig(
        Guid id,
        Guid tenantChatWidgetConfigId,
        Guid tenantId,
        string channelId,
        string? domainsAllowedJson = "[]",
        string? configJson = "{}",
        bool isEnabled = true,
        int configVersion = 1)
        : base(id)
    {
        TenantChatWidgetConfigId = tenantChatWidgetConfigId;
        TenantId = tenantId;
        ChannelId = Check.NotNullOrWhiteSpace(channelId, nameof(channelId), ChatWidgetConsts.MaxChannelIdLength);
        IsEnabled = isEnabled;
        DomainsAllowedJson = domainsAllowedJson is null
            ? null
            : Check.NotNullOrWhiteSpace(domainsAllowedJson, nameof(domainsAllowedJson));
        ConfigJson = configJson is null
            ? null
            : Check.NotNullOrWhiteSpace(configJson, nameof(configJson));
        ConfigVersion = configVersion;
    }

    public void Update(bool isEnabled, string domainsAllowedJson, string configJson)
    {
        IsEnabled = isEnabled;
        DomainsAllowedJson = Check.NotNullOrWhiteSpace(domainsAllowedJson, nameof(domainsAllowedJson));
        ConfigJson = Check.NotNullOrWhiteSpace(configJson, nameof(configJson));
        ConfigVersion++;
    }
}
