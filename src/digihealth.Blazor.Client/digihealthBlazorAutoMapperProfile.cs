using AutoMapper;
using DigiHealth.ConfigurationService;

namespace digihealth.Blazor.Client;

public class digihealthBlazorAutoMapperProfile : Profile
{
    public digihealthBlazorAutoMapperProfile()
    {
        CreateMap<AppointmentStatusDto, CreateUpdateAppointmentStatusDto>();
        CreateMap<AppointmentChannelDto, CreateUpdateAppointmentChannelDto>();
        CreateMap<ConsentPartyTypeDto, CreateUpdateConsentPartyTypeDto>();
        CreateMap<ConsentStatusDto, CreateUpdateConsentStatusDto>();
        CreateMap<DayOfWeekConfigDto, CreateUpdateDayOfWeekConfigDto>();
        CreateMap<DeviceTypeDto, CreateUpdateDeviceTypeDto>();
        CreateMap<MedicationIntakeStatusDto, CreateUpdateMedicationIntakeStatusDto>();
        CreateMap<NotificationChannelDto, CreateUpdateNotificationChannelDto>();
        CreateMap<NotificationStatusDto, CreateUpdateNotificationStatusDto>();
        CreateMap<VaultRecordTypeDto, CreateUpdateVaultRecordTypeDto>();
    }
}
