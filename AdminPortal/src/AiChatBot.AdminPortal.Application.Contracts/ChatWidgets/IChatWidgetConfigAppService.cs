using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Services;

namespace AiChatBot.AdminPortal.ChatWidgets;

public interface IChatWidgetConfigAppService : IApplicationService
{
    Task<ChatWidgetConfigDto> GetAsync();

    Task<ChatWidgetConfigDto> UpdateAsync(UpdateChatWidgetConfigDto input);

    Task<ChatWidgetChannelConfigDto> GetChannelAsync([StringLength(64)] string channelId);

    Task<ChatWidgetChannelConfigDto> UpdateChannelAsync([StringLength(64)] string channelId, UpdateChatWidgetChannelConfigDto input);
}
