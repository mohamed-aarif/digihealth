using System;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using DigiHealth.ConfigurationService.Repositories;
using Volo.Abp.Domain.Repositories.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore;

namespace DigiHealth.ConfigurationService.EntityFrameworkCore.Repositories;

public class AppointmentStatusRepository : EfCoreRepository<ConfigurationServiceDbContext, AppointmentStatus, Guid>, IAppointmentStatusRepository
{
    public AppointmentStatusRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class AppointmentChannelRepository : EfCoreRepository<ConfigurationServiceDbContext, AppointmentChannel, Guid>, IAppointmentChannelRepository
{
    public AppointmentChannelRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class ConsentPartyTypeRepository : EfCoreRepository<ConfigurationServiceDbContext, ConsentPartyType, Guid>, IConsentPartyTypeRepository
{
    public ConsentPartyTypeRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class ConsentStatusRepository : EfCoreRepository<ConfigurationServiceDbContext, ConsentStatus, Guid>, IConsentStatusRepository
{
    public ConsentStatusRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class DayOfWeekConfigRepository : EfCoreRepository<ConfigurationServiceDbContext, DayOfWeekConfig, Guid>, IDayOfWeekConfigRepository
{
    public DayOfWeekConfigRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class DeviceTypeConfigRepository : EfCoreRepository<ConfigurationServiceDbContext, DeviceTypeConfig, Guid>, IDeviceTypeConfigRepository
{
    public DeviceTypeConfigRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class MedicationIntakeStatusRepository : EfCoreRepository<ConfigurationServiceDbContext, MedicationIntakeStatus, Guid>, IMedicationIntakeStatusRepository
{
    public MedicationIntakeStatusRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class NotificationChannelConfigRepository : EfCoreRepository<ConfigurationServiceDbContext, NotificationChannelConfig, Guid>, INotificationChannelConfigRepository
{
    public NotificationChannelConfigRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class NotificationStatusConfigRepository : EfCoreRepository<ConfigurationServiceDbContext, NotificationStatusConfig, Guid>, INotificationStatusConfigRepository
{
    public NotificationStatusConfigRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}

public class VaultRecordTypeConfigRepository : EfCoreRepository<ConfigurationServiceDbContext, VaultRecordTypeConfig, Guid>, IVaultRecordTypeConfigRepository
{
    public VaultRecordTypeConfigRepository(IDbContextProvider<ConfigurationServiceDbContext> dbContextProvider) : base(dbContextProvider)
    {
    }
}
