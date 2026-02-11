using AutoMapper;

namespace AiChatBot.AdminPortal.ChatWidgets;

public class AdminPortalChatWidgetApplicationAutoMapperProfile : Profile
{
    public AdminPortalChatWidgetApplicationAutoMapperProfile()
    {
        CreateMap<TenantChatWidgetConfig, ChatWidgetConfigDto>();
        CreateMap<TenantChatWidgetChannelConfig, ChatWidgetChannelConfigDto>();
    }
}
