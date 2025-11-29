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

        CreateMap<DeviceTypeConfig, DeviceTypeConfigDto>();
        CreateMap<CreateUpdateDeviceTypeConfigDto, DeviceTypeConfig>();

        CreateMap<MedicationIntakeStatus, MedicationIntakeStatusDto>();
        CreateMap<CreateUpdateMedicationIntakeStatusDto, MedicationIntakeStatus>();

        CreateMap<NotificationChannelConfig, NotificationChannelConfigDto>();
        CreateMap<CreateUpdateNotificationChannelConfigDto, NotificationChannelConfig>();

        CreateMap<NotificationStatusConfig, NotificationStatusConfigDto>();
        CreateMap<CreateUpdateNotificationStatusConfigDto, NotificationStatusConfig>();

        CreateMap<VaultRecordTypeConfig, VaultRecordTypeConfigDto>();
        CreateMap<CreateUpdateVaultRecordTypeConfigDto, VaultRecordTypeConfig>();
    }
}
