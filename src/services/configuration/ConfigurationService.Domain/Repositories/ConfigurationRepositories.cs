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

public interface IDeviceTypeConfigRepository : IRepository<DeviceTypeConfig, Guid>
{
}

public interface IMedicationIntakeStatusRepository : IRepository<MedicationIntakeStatus, Guid>
{
}

public interface INotificationChannelConfigRepository : IRepository<NotificationChannelConfig, Guid>
{
}

public interface INotificationStatusConfigRepository : IRepository<NotificationStatusConfig, Guid>
{
}

public interface IVaultRecordTypeConfigRepository : IRepository<VaultRecordTypeConfig, Guid>
{
}
