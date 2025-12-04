using System;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using Volo.Abp.Domain.Repositories;

namespace DigiHealth.ConfigurationService.Repositories;

public interface IAppointmentStatusRepository : IRepository<AppointmentStatus, Guid>
{
}

public interface IAppointmentChannelRepository : IRepository<AppointmentChannel, Guid>
{
}

public interface IConsentPartyTypeRepository : IRepository<ConsentPartyType, Guid>
{
}

public interface IConsentStatusRepository : IRepository<ConsentStatus, Guid>
{
}

public interface IDayOfWeekConfigRepository : IRepository<DayOfWeekConfig, Guid>
{
}

public interface IDeviceTypeRepository : IRepository<DeviceType, Guid>
{
}

public interface IDeviceReadingTypeRepository : IRepository<DeviceReadingType, Guid>
{
}

public interface IMedicationIntakeStatusRepository : IRepository<MedicationIntakeStatus, Guid>
{
}

public interface INotificationChannelRepository : IRepository<NotificationChannel, Guid>
{
}

public interface INotificationStatusRepository : IRepository<NotificationStatus, Guid>
{
}

public interface IRelationshipTypeRepository : IRepository<RelationshipType, Guid>
{
}

public interface IVaultRecordTypeRepository : IRepository<VaultRecordType, Guid>
{
}
