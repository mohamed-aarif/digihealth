using System.ComponentModel.DataAnnotations;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class UpdateChatWidgetConfigDto
{
    public bool IsEnabled { get; set; }

    [Required]
    public string DefaultConfigJson { get; set; }

    public UpdateChatWidgetConfigDto()
    {
        DefaultConfigJson = "{}";
    }
}
