using AiChatBot.AdminPortal.ChatWidgets;
using AiChatBot.AdminPortal.Permissions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.AspNetCore.Mvc;

namespace AiChatBot.AdminPortal.HttpApi.Controllers;

[Authorize(AdminPortalPermissions.ChatWidgets.Manage)]
[ApiController]
[Route("api/admin/chat-widget")]
public class AdminChatWidgetConfigController : AbpController
{
    private readonly IChatWidgetConfigAppService _chatWidgetConfigAppService;

    public AdminChatWidgetConfigController(IChatWidgetConfigAppService chatWidgetConfigAppService)
    {
        _chatWidgetConfigAppService = chatWidgetConfigAppService;
    }

    [HttpGet("config")]
    public virtual Task<ChatWidgetConfigDto> GetConfigAsync()
    {
        return _chatWidgetConfigAppService.GetAsync();
    }

    [HttpPut("config")]
    public virtual Task<ChatWidgetConfigDto> UpdateConfigAsync([FromBody] UpdateChatWidgetConfigDto input)
    {
        return _chatWidgetConfigAppService.UpdateAsync(input);
    }

    [HttpGet("channels/{channelId}")]
    public virtual Task<ChatWidgetChannelConfigDto> GetChannelAsync([FromRoute] string channelId)
    {
        return _chatWidgetConfigAppService.GetChannelAsync(channelId);
    }

    [HttpPut("channels/{channelId}")]
    public virtual Task<ChatWidgetChannelConfigDto> UpdateChannelAsync(
        [FromRoute] string channelId,
        [FromBody] UpdateChatWidgetChannelConfigDto input)
    {
        return _chatWidgetConfigAppService.UpdateChannelAsync(channelId, input);
    }
}
