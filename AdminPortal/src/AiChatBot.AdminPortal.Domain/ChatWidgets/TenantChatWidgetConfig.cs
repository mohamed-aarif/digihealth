using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class TenantChatWidgetConfig : AggregateRoot<Guid>, IMultiTenant
{
    public Guid? TenantId { get; protected set; }

    public bool IsEnabled { get; protected set; }

    public string DefaultConfigJson { get; protected set; }

    public int ConfigVersion { get; protected set; }

    public ICollection<TenantChatWidgetChannelConfig> Channels { get; protected set; }

    protected TenantChatWidgetConfig()
    {
        DefaultConfigJson = "{}";
        Channels = new List<TenantChatWidgetChannelConfig>();
        IsEnabled = true;
        ConfigVersion = 1;
    }

    public TenantChatWidgetConfig(
        Guid id,
        Guid tenantId,
        string defaultConfigJson = "{}",
        bool isEnabled = true,
        int configVersion = 1)
        : base(id)
    {
        TenantId = tenantId;
        IsEnabled = isEnabled;
        ConfigVersion = configVersion;
        DefaultConfigJson = Check.NotNullOrWhiteSpace(defaultConfigJson, nameof(defaultConfigJson));
        Channels = new List<TenantChatWidgetChannelConfig>();
    }

    public void Update(bool isEnabled, string defaultConfigJson)
    {
        IsEnabled = isEnabled;
        DefaultConfigJson = Check.NotNullOrWhiteSpace(defaultConfigJson, nameof(defaultConfigJson));
        ConfigVersion++;
    }
}
