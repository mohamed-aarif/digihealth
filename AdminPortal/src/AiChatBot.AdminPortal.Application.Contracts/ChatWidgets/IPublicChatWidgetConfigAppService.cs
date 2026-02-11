using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Services;

namespace AiChatBot.AdminPortal.ChatWidgets;

public interface IPublicChatWidgetConfigAppService : IApplicationService
{
    Task<PublicChatWidgetConfigDto> GetPublicAsync([StringLength(64)] string? channelId = null, string? domain = null);
}
