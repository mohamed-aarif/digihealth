using System;
using System.Threading.Tasks;
using AiChatBot.AdminPortal.ChatWidgets;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.MultiTenancy;
using Volo.Abp.TenantManagement;

namespace AiChatBot.AdminPortal.Data;

public class ChatWidgetConfigDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private static readonly string DefaultConfigJson =
        """
        {
          "branding": { "headerText": "AED Assistant", "assistantName": "AED Assistant", "watermarkText": "African + Eastern" },
          "theme": { "themeMode": "auto", "accentColor": "#B11226", "fontFamily": "Inter, Arial, sans-serif", "cssInjectMode": "scoped", "cssScopeSelector": "#aed-chat-widget", "customCss": "" },
          "behavior": { "streamingEnabled": true, "typingIndicatorEnabled": true, "suggestedPromptsEnabled": true, "suggestedPrompts": ["Find red wine under AED 100"], "sessionPersistence": "browser" },
          "commerce": { "locationSelectorEnabled": true, "enableAddToCartFromChat": true, "enableOrderTracking": true },
          "analytics": { "telemetryEnabled": true, "provider": "GA4" }
        }
        """;

    private readonly IRepository<TenantChatWidgetConfig, Guid> _tenantConfigRepository;
    private readonly IRepository<TenantChatWidgetChannelConfig, Guid> _channelConfigRepository;
    private readonly ITenantRepository _tenantRepository;
    private readonly ICurrentTenant _currentTenant;

    public ChatWidgetConfigDataSeedContributor(
        IRepository<TenantChatWidgetConfig, Guid> tenantConfigRepository,
        IRepository<TenantChatWidgetChannelConfig, Guid> channelConfigRepository,
        ITenantRepository tenantRepository,
        ICurrentTenant currentTenant)
    {
        _tenantConfigRepository = tenantConfigRepository;
        _channelConfigRepository = channelConfigRepository;
        _tenantRepository = tenantRepository;
        _currentTenant = currentTenant;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var tenants = await _tenantRepository.GetListAsync();
        foreach (var tenant in tenants)
        {
            using (_currentTenant.Change(tenant.Id))
            {
                await SeedTenantAsync(tenant.Id);
            }
        }
    }

    private async Task SeedTenantAsync(Guid tenantId)
    {
        var tenantConfig = await _tenantConfigRepository.FirstOrDefaultAsync(x => x.TenantId == tenantId);
        if (tenantConfig == null)
        {
            tenantConfig = new TenantChatWidgetConfig(
                Guid.NewGuid(),
                tenantId,
                DefaultConfigJson,
                isEnabled: true,
                configVersion: 1);

            tenantConfig = await _tenantConfigRepository.InsertAsync(tenantConfig, autoSave: true);
        }

        await SeedChannelIfMissingAsync(
            tenantConfig,
            tenantId,
            "AED_DXB",
            "dxb.example.com",
            "AED Assistant - Dubai",
            "#B11226");

        await SeedChannelIfMissingAsync(
            tenantConfig,
            tenantId,
            "AED_AUH",
            "auh.example.com",
            "AED Assistant - Abu Dhabi",
            "#0E7A52");

        await SeedChannelIfMissingAsync(
            tenantConfig,
            tenantId,
            "Corporate",
            "corp.example.com",
            "AED Corporate Assistant",
            "#1E3A8A");
    }

    private async Task SeedChannelIfMissingAsync(
        TenantChatWidgetConfig tenantConfig,
        Guid tenantId,
        string channelId,
        string domain,
        string headerText,
        string accentColor)
    {
        var existing = await _channelConfigRepository.FirstOrDefaultAsync(
            x => x.TenantId == tenantId && x.ChannelId == channelId);

        if (existing != null)
        {
            return;
        }

        var domainsAllowedJson = $"[\"{domain}\"]";
        var configJson =
            $"{{\"branding\":{{\"headerText\":\"{headerText}\"}},\"theme\":{{\"accentColor\":\"{accentColor}\"}}}}";

        var channel = new TenantChatWidgetChannelConfig(
            Guid.NewGuid(),
            tenantConfig.Id,
            tenantId,
            channelId,
            domainsAllowedJson,
            configJson,
            isEnabled: true,
            configVersion: 1);

        await _channelConfigRepository.InsertAsync(channel, autoSave: true);
    }
}
