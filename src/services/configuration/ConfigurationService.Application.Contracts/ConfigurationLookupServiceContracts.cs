using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace DigiHealth.ConfigurationService;

public interface IAppointmentStatusAppService :
    ICrudAppService<AppointmentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentStatusDto>
{
}

public interface IAppointmentChannelAppService :
    ICrudAppService<AppointmentChannelDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentChannelDto>
{
}

public interface IConsentPartyTypeAppService :
    ICrudAppService<ConsentPartyTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentPartyTypeDto>
{
}

public interface IConsentStatusAppService :
    ICrudAppService<ConsentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentStatusDto>
{
}

public interface IDayOfWeekConfigAppService :
    ICrudAppService<DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDayOfWeekConfigDto>
{
}

public interface IDeviceTypeConfigAppService :
    ICrudAppService<DeviceTypeConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDeviceTypeConfigDto>
{
}

public interface IMedicationIntakeStatusAppService :
    ICrudAppService<MedicationIntakeStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateMedicationIntakeStatusDto>
{
}

public interface INotificationChannelConfigAppService :
    ICrudAppService<NotificationChannelConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationChannelConfigDto>
{
}

public interface INotificationStatusConfigAppService :
    ICrudAppService<NotificationStatusConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationStatusConfigDto>
{
}

public interface IVaultRecordTypeConfigAppService :
    ICrudAppService<VaultRecordTypeConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateVaultRecordTypeConfigDto>
{
}
