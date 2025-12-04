using AutoMapper;
using DigiHealth.ConfigurationService.ConfigurationLookups;

namespace DigiHealth.ConfigurationService;

public class ConfigurationServiceApplicationAutoMapperProfile : Profile
{
    public ConfigurationServiceApplicationAutoMapperProfile()
    {
        CreateMap<AppointmentStatus, AppointmentStatusDto>();
        CreateMap<CreateUpdateAppointmentStatusDto, AppointmentStatus>();

        CreateMap<AppointmentChannel, AppointmentChannelDto>();
        CreateMap<CreateUpdateAppointmentChannelDto, AppointmentChannel>();

        CreateMap<ConsentPartyType, ConsentPartyTypeDto>();
        CreateMap<CreateUpdateConsentPartyTypeDto, ConsentPartyType>();

        CreateMap<ConsentStatus, ConsentStatusDto>();
        CreateMap<CreateUpdateConsentStatusDto, ConsentStatus>();

        CreateMap<DayOfWeekConfig, DayOfWeekConfigDto>();
        CreateMap<CreateUpdateDayOfWeekConfigDto, DayOfWeekConfig>();

        CreateMap<DeviceType, DeviceTypeDto>();
        CreateMap<CreateUpdateDeviceTypeDto, DeviceType>();

        CreateMap<MedicationIntakeStatus, MedicationIntakeStatusDto>();
        CreateMap<CreateUpdateMedicationIntakeStatusDto, MedicationIntakeStatus>();

        CreateMap<NotificationChannel, NotificationChannelDto>();
        CreateMap<CreateUpdateNotificationChannelDto, NotificationChannel>();

        CreateMap<NotificationStatus, NotificationStatusDto>();
        CreateMap<CreateUpdateNotificationStatusDto, NotificationStatus>();

        CreateMap<VaultRecordType, VaultRecordTypeDto>();
        CreateMap<CreateUpdateVaultRecordTypeDto, VaultRecordType>();
    }
}
