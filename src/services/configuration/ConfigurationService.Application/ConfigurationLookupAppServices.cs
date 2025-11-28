using System;
using System.Linq;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.RemoteService;

namespace DigiHealth.ConfigurationService;

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class AppointmentStatusAppService : CrudAppService<AppointmentStatus, AppointmentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentStatusDto>, IAppointmentStatusAppService
{
    public AppointmentStatusAppService(IRepository<AppointmentStatus, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<AppointmentStatus> ApplyDefaultSorting(IQueryable<AppointmentStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class AppointmentChannelAppService : CrudAppService<AppointmentChannel, AppointmentChannelDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateAppointmentChannelDto>, IAppointmentChannelAppService
{
    public AppointmentChannelAppService(IRepository<AppointmentChannel, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<AppointmentChannel> ApplyDefaultSorting(IQueryable<AppointmentChannel> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class ConsentPartyTypeAppService : CrudAppService<ConsentPartyType, ConsentPartyTypeDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentPartyTypeDto>, IConsentPartyTypeAppService
{
    public ConsentPartyTypeAppService(IRepository<ConsentPartyType, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<ConsentPartyType> ApplyDefaultSorting(IQueryable<ConsentPartyType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class ConsentStatusAppService : CrudAppService<ConsentStatus, ConsentStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateConsentStatusDto>, IConsentStatusAppService
{
    public ConsentStatusAppService(IRepository<ConsentStatus, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<ConsentStatus> ApplyDefaultSorting(IQueryable<ConsentStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class DayOfWeekConfigAppService : CrudAppService<DayOfWeekConfig, DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDayOfWeekConfigDto>, IDayOfWeekConfigAppService
{
    public DayOfWeekConfigAppService(IRepository<DayOfWeekConfig, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<DayOfWeekConfig> ApplyDefaultSorting(IQueryable<DayOfWeekConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class DeviceTypeConfigAppService : CrudAppService<DeviceTypeConfig, DeviceTypeConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDeviceTypeConfigDto>, IDeviceTypeConfigAppService
{
    public DeviceTypeConfigAppService(IRepository<DeviceTypeConfig, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<DeviceTypeConfig> ApplyDefaultSorting(IQueryable<DeviceTypeConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class MedicationIntakeStatusAppService : CrudAppService<MedicationIntakeStatus, MedicationIntakeStatusDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateMedicationIntakeStatusDto>, IMedicationIntakeStatusAppService
{
    public MedicationIntakeStatusAppService(IRepository<MedicationIntakeStatus, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<MedicationIntakeStatus> ApplyDefaultSorting(IQueryable<MedicationIntakeStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class NotificationChannelConfigAppService : CrudAppService<NotificationChannelConfig, NotificationChannelConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationChannelConfigDto>, INotificationChannelConfigAppService
{
    public NotificationChannelConfigAppService(IRepository<NotificationChannelConfig, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<NotificationChannelConfig> ApplyDefaultSorting(IQueryable<NotificationChannelConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class NotificationStatusConfigAppService : CrudAppService<NotificationStatusConfig, NotificationStatusConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateNotificationStatusConfigDto>, INotificationStatusConfigAppService
{
    public NotificationStatusConfigAppService(IRepository<NotificationStatusConfig, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<NotificationStatusConfig> ApplyDefaultSorting(IQueryable<NotificationStatusConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class VaultRecordTypeConfigAppService : CrudAppService<VaultRecordTypeConfig, VaultRecordTypeConfigDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateVaultRecordTypeConfigDto>, IVaultRecordTypeConfigAppService
{
    public VaultRecordTypeConfigAppService(IRepository<VaultRecordTypeConfig, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<VaultRecordTypeConfig> ApplyDefaultSorting(IQueryable<VaultRecordTypeConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}
