using System.ComponentModel.DataAnnotations;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class UpdateChatWidgetChannelConfigDto
{
    public bool IsEnabled { get; set; }

    [Required]
    public string DomainsAllowedJson { get; set; }

    [Required]
    public string ConfigJson { get; set; }

    public UpdateChatWidgetChannelConfigDto()
    {
        DomainsAllowedJson = "[]";
        ConfigJson = "{}";
    }
}
