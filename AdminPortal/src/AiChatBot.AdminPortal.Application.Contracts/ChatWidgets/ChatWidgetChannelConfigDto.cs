using System.ComponentModel.DataAnnotations;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class ChatWidgetChannelConfigDto
{
    [Required]
    [StringLength(64)]
    public string ChannelId { get; set; }

    public bool IsEnabled { get; set; }

    [Required]
    public string DomainsAllowedJson { get; set; }

    [Required]
    public string ConfigJson { get; set; }

    public int ConfigVersion { get; set; }

    public ChatWidgetChannelConfigDto()
    {
        ChannelId = string.Empty;
        DomainsAllowedJson = "[]";
        ConfigJson = "{}";
    }
}
