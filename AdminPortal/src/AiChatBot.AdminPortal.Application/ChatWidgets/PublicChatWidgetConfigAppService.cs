using System.Linq;
using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.MultiTenancy;

namespace AiChatBot.AdminPortal.ChatWidgets;

[AllowAnonymous]
public class PublicChatWidgetConfigAppService : ApplicationService, IPublicChatWidgetConfigAppService
{
    private readonly IRepository<TenantChatWidgetConfig, Guid> _tenantConfigRepository;
    private readonly IRepository<TenantChatWidgetChannelConfig, Guid> _channelConfigRepository;
    private readonly ICurrentTenant _currentTenant;

    public PublicChatWidgetConfigAppService(
        IRepository<TenantChatWidgetConfig, Guid> tenantConfigRepository,
        IRepository<TenantChatWidgetChannelConfig, Guid> channelConfigRepository,
        ICurrentTenant currentTenant)
    {
        _tenantConfigRepository = tenantConfigRepository;
        _channelConfigRepository = channelConfigRepository;
        _currentTenant = currentTenant;
    }

    public virtual async Task<PublicChatWidgetConfigDto> GetPublicAsync(string? channelId = null, string? domain = null)
    {
        var tenantId = GetRequiredTenantId();
        var effectiveChannelId = string.IsNullOrWhiteSpace(channelId) ? "default" : channelId;

        var tenantConfig = await _tenantConfigRepository.FirstOrDefaultAsync(x => x.TenantId == tenantId)
            ?? new TenantChatWidgetConfig(Guid.Empty, tenantId);

        var channels = await _channelConfigRepository.GetListAsync(
            x => x.TenantId == tenantId && x.ChannelId == effectiveChannelId);

        var channelConfig = ResolveChannel(channels, domain);

        var effectiveConfigJson = MergeJsonObjects(
            tenantConfig.DefaultConfigJson,
            channelConfig?.ConfigJson ?? "{}");

        return new PublicChatWidgetConfigDto
        {
            TenantId = tenantId,
            ChannelId = effectiveChannelId,
            Enabled = tenantConfig.IsEnabled && (channelConfig?.IsEnabled ?? true),
            Version = Math.Max(tenantConfig.ConfigVersion, channelConfig?.ConfigVersion ?? 0),
            EffectiveConfigJson = effectiveConfigJson,
            DomainsAllowedJson = channelConfig?.DomainsAllowedJson ?? "[]"
        };
    }

    private static TenantChatWidgetChannelConfig? ResolveChannel(
        IReadOnlyList<TenantChatWidgetChannelConfig> channels,
        string? domain)
    {
        if (channels.Count == 0)
        {
            return null;
        }

        if (string.IsNullOrWhiteSpace(domain))
        {
            return channels.FirstOrDefault();
        }

        return channels.FirstOrDefault(x => x.DomainsAllowedJson?.Contains(domain, StringComparison.OrdinalIgnoreCase) == true);
    }

    private static string MergeJsonObjects(string defaultJson, string overrideJson)
    {
        var baseDictionary = ParseJsonObject(defaultJson);
        var overrideDictionary = ParseJsonObject(overrideJson);

        foreach (var kvp in overrideDictionary)
        {
            baseDictionary[kvp.Key] = kvp.Value;
        }

        return JsonSerializer.Serialize(baseDictionary);
    }

    private static Dictionary<string, object?> ParseJsonObject(string json)
    {
        var value = string.IsNullOrWhiteSpace(json) ? "{}" : json;
        using var document = JsonDocument.Parse(value);

        if (document.RootElement.ValueKind != JsonValueKind.Object)
        {
            return new Dictionary<string, object?>();
        }

        var dictionary = new Dictionary<string, object?>();
        foreach (var property in document.RootElement.EnumerateObject())
        {
            dictionary[property.Name] = ConvertJsonElement(property.Value);
        }

        return dictionary;
    }

    private static object? ConvertJsonElement(JsonElement element)
    {
        return element.ValueKind switch
        {
            JsonValueKind.Object => element.EnumerateObject()
                .ToDictionary(p => p.Name, p => ConvertJsonElement(p.Value)),
            JsonValueKind.Array => element.EnumerateArray()
                .Select(ConvertJsonElement)
                .ToList(),
            JsonValueKind.String => element.GetString(),
            JsonValueKind.Number when element.TryGetInt64(out var longValue) => longValue,
            JsonValueKind.Number => element.GetDouble(),
            JsonValueKind.True => true,
            JsonValueKind.False => false,
            JsonValueKind.Null => null,
            _ => element.GetRawText()
        };
    }

    private Guid GetRequiredTenantId()
    {
        if (_currentTenant.Id.HasValue)
        {
            return _currentTenant.Id.Value;
        }

        throw new AbpException("Tenant context is required for public chat widget configuration.");
    }
}
