using AiChatBot.AdminPortal.Permissions;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.MultiTenancy;

namespace AiChatBot.AdminPortal.ChatWidgets;

[Authorize(AdminPortalPermissions.ChatWidgets.Manage)]
public class ChatWidgetConfigAppService : AdminPortalAppService, IChatWidgetConfigAppService
{
    private readonly IRepository<TenantChatWidgetConfig, Guid> _tenantConfigRepository;
    private readonly IRepository<TenantChatWidgetChannelConfig, Guid> _channelConfigRepository;
    private readonly ICurrentTenant _currentTenant;

    public ChatWidgetConfigAppService(
        IRepository<TenantChatWidgetConfig, Guid> tenantConfigRepository,
        IRepository<TenantChatWidgetChannelConfig, Guid> channelConfigRepository,
        ICurrentTenant currentTenant)
    {
        _tenantConfigRepository = tenantConfigRepository;
        _channelConfigRepository = channelConfigRepository;
        _currentTenant = currentTenant;
    }

    public virtual async Task<ChatWidgetConfigDto> GetAsync()
    {
        var config = await GetOrCreateTenantConfigAsync();
        return await MapTenantConfigAsync(config);
    }

    public virtual async Task<ChatWidgetConfigDto> UpdateAsync(UpdateChatWidgetConfigDto input)
    {
        var config = await GetOrCreateTenantConfigAsync();
        config.Update(input.IsEnabled, input.DefaultConfigJson);
        await _tenantConfigRepository.UpdateAsync(config, autoSave: true);

        return await MapTenantConfigAsync(config);
    }

    public virtual async Task<ChatWidgetChannelConfigDto> GetChannelAsync(string channelId)
    {
        var config = await GetOrCreateTenantConfigAsync();
        var channel = await GetOrCreateChannelConfigAsync(config, channelId);

        return ObjectMapper.Map<TenantChatWidgetChannelConfig, ChatWidgetChannelConfigDto>(channel);
    }

    public virtual async Task<ChatWidgetChannelConfigDto> UpdateChannelAsync(string channelId, UpdateChatWidgetChannelConfigDto input)
    {
        var config = await GetOrCreateTenantConfigAsync();
        var channel = await GetOrCreateChannelConfigAsync(config, channelId);

        channel.Update(input.IsEnabled, input.DomainsAllowedJson, input.ConfigJson);
        await _channelConfigRepository.UpdateAsync(channel, autoSave: true);

        return ObjectMapper.Map<TenantChatWidgetChannelConfig, ChatWidgetChannelConfigDto>(channel);
    }

    private async Task<TenantChatWidgetConfig> GetOrCreateTenantConfigAsync()
    {
        var tenantId = GetRequiredTenantId();

        var config = await _tenantConfigRepository.FirstOrDefaultAsync(x => x.TenantId == tenantId);
        if (config != null)
        {
            return config;
        }

        config = new TenantChatWidgetConfig(GuidGenerator.Create(), tenantId);
        return await _tenantConfigRepository.InsertAsync(config, autoSave: true);
    }

    private async Task<TenantChatWidgetChannelConfig> GetOrCreateChannelConfigAsync(
        TenantChatWidgetConfig tenantConfig,
        string channelId)
    {
        var tenantId = GetRequiredTenantId();
        var normalizedChannelId = Check.NotNullOrWhiteSpace(channelId, nameof(channelId), ChatWidgetConsts.MaxChannelIdLength);

        var channel = await _channelConfigRepository.FirstOrDefaultAsync(
            x => x.TenantId == tenantId && x.ChannelId == normalizedChannelId);

        if (channel != null)
        {
            return channel;
        }

        channel = new TenantChatWidgetChannelConfig(
            GuidGenerator.Create(),
            tenantConfig.Id,
            tenantId,
            normalizedChannelId);

        return await _channelConfigRepository.InsertAsync(channel, autoSave: true);
    }

    private async Task<ChatWidgetConfigDto> MapTenantConfigAsync(TenantChatWidgetConfig config)
    {
        var dto = ObjectMapper.Map<TenantChatWidgetConfig, ChatWidgetConfigDto>(config);
        var tenantId = GetRequiredTenantId();
        var channels = await _channelConfigRepository.GetListAsync(x => x.TenantId == tenantId);
        dto.Channels = ObjectMapper.Map<List<TenantChatWidgetChannelConfig>, List<ChatWidgetChannelConfigDto>>(channels);
        return dto;
    }

    private Guid GetRequiredTenantId()
    {
        if (_currentTenant.Id.HasValue)
        {
            return _currentTenant.Id.Value;
        }

        throw new AbpException("Tenant context is required for chat widget configuration operations.");
    }
}
