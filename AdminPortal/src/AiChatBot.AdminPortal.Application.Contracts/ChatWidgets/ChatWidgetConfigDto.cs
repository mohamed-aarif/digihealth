using System.ComponentModel.DataAnnotations;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class ChatWidgetConfigDto
{
    public Guid TenantId { get; set; }

    public bool IsEnabled { get; set; }

    [Required]
    public string DefaultConfigJson { get; set; }

    public int ConfigVersion { get; set; }

    public List<ChatWidgetChannelConfigDto> Channels { get; set; }

    public ChatWidgetConfigDto()
    {
        DefaultConfigJson = "{}";
        Channels = new List<ChatWidgetChannelConfigDto>();
    }
}
