using AiChatBot.AdminPortal.ChatWidgets;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.AspNetCore.Mvc;

namespace AiChatBot.AdminPortal.HttpApi.Controllers;

[AllowAnonymous]
[ApiController]
[Route("api/chat-widget")]
public class PublicChatWidgetConfigController : AbpController
{
    private readonly IPublicChatWidgetConfigAppService _publicChatWidgetConfigAppService;

    public PublicChatWidgetConfigController(IPublicChatWidgetConfigAppService publicChatWidgetConfigAppService)
    {
        _publicChatWidgetConfigAppService = publicChatWidgetConfigAppService;
    }

    [HttpGet("config")]
    public virtual Task<PublicChatWidgetConfigDto> GetConfigAsync(
        [FromQuery] string? channelId = null,
        [FromQuery] string? domain = null)
    {
        return _publicChatWidgetConfigAppService.GetPublicAsync(channelId, domain);
    }
}
