using System.ComponentModel.DataAnnotations;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class PublicChatWidgetConfigDto
{
    public Guid TenantId { get; set; }

    [Required]
    [StringLength(64)]
    public string ChannelId { get; set; }

    public bool Enabled { get; set; }

    public int Version { get; set; }

    [Required]
    public string EffectiveConfigJson { get; set; }

    [Required]
    public string DomainsAllowedJson { get; set; }

    public PublicChatWidgetConfigDto()
    {
        ChannelId = string.Empty;
        EffectiveConfigJson = "{}";
        DomainsAllowedJson = "[]";
    }
}
