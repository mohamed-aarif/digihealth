using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace DigiHealth.ConfigurationService;

public interface IAppointmentStatusAppService :
    ICrudAppService<AppointmentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentStatusDto,
        CreateUpdateAppointmentStatusDto>
{
}

public interface IAppointmentChannelAppService :
    ICrudAppService<AppointmentChannelDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentChannelDto,
        CreateUpdateAppointmentChannelDto>
{
}

public interface IConsentPartyTypeAppService :
    ICrudAppService<ConsentPartyTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentPartyTypeDto,
        CreateUpdateConsentPartyTypeDto>
{
}

public interface IConsentStatusAppService :
    ICrudAppService<ConsentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentStatusDto,
        CreateUpdateConsentStatusDto>
{
}

public interface IDayOfWeekConfigAppService :
    ICrudAppService<DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDayOfWeekConfigDto,
        CreateUpdateDayOfWeekConfigDto>
{
}

public interface IDeviceTypeAppService :
    ICrudAppService<DeviceTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDeviceTypeDto, CreateUpdateDeviceTypeDto>
{
}

public interface IDeviceReadingTypeAppService :
    ICrudAppService<DeviceReadingTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDeviceReadingTypeDto,
        CreateUpdateDeviceReadingTypeDto>
{
}

public interface IMedicationIntakeStatusAppService :
    ICrudAppService<MedicationIntakeStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateMedicationIntakeStatusDto,
        CreateUpdateMedicationIntakeStatusDto>
{
}

public interface INotificationChannelAppService :
    ICrudAppService<NotificationChannelDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationChannelDto,
        CreateUpdateNotificationChannelDto>
{
}

public interface INotificationStatusAppService :
    ICrudAppService<NotificationStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationStatusDto,
        CreateUpdateNotificationStatusDto>
{
}

public interface IRelationshipTypeAppService :
    ICrudAppService<RelationshipTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateRelationshipTypeDto,
        CreateUpdateRelationshipTypeDto>
{
}

public interface IVaultRecordTypeAppService :
    ICrudAppService<VaultRecordTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateVaultRecordTypeDto,
        CreateUpdateVaultRecordTypeDto>
{
}
