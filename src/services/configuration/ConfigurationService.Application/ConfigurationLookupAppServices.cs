using System;
using System.Linq;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace DigiHealth.ConfigurationService;

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class AppointmentStatusAppService : CrudAppService<AppointmentStatus, AppointmentStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateAppointmentStatusDto, CreateUpdateAppointmentStatusDto>, IAppointmentStatusAppService
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
public class AppointmentChannelAppService : CrudAppService<AppointmentChannel, AppointmentChannelDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateAppointmentChannelDto, CreateUpdateAppointmentChannelDto>, IAppointmentChannelAppService
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
public class ConsentPartyTypeAppService : CrudAppService<ConsentPartyType, ConsentPartyTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateConsentPartyTypeDto, CreateUpdateConsentPartyTypeDto>, IConsentPartyTypeAppService
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
public class ConsentStatusAppService : CrudAppService<ConsentStatus, ConsentStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateConsentStatusDto, CreateUpdateConsentStatusDto>, IConsentStatusAppService
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
public class DayOfWeekConfigAppService : CrudAppService<DayOfWeekConfig, DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateDayOfWeekConfigDto, CreateUpdateDayOfWeekConfigDto>, IDayOfWeekConfigAppService
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
public class DeviceTypeAppService : CrudAppService<DeviceType, DeviceTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateDeviceTypeDto, CreateUpdateDeviceTypeDto>, IDeviceTypeAppService
{
    public DeviceTypeAppService(IRepository<DeviceType, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<DeviceType> ApplyDefaultSorting(IQueryable<DeviceType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class MedicationIntakeStatusAppService : CrudAppService<MedicationIntakeStatus, MedicationIntakeStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateMedicationIntakeStatusDto, CreateUpdateMedicationIntakeStatusDto>, IMedicationIntakeStatusAppService
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
public class NotificationChannelAppService : CrudAppService<NotificationChannel, NotificationChannelDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateNotificationChannelDto, CreateUpdateNotificationChannelDto>, INotificationChannelAppService
{
    public NotificationChannelAppService(IRepository<NotificationChannel, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<NotificationChannel> ApplyDefaultSorting(IQueryable<NotificationChannel> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class NotificationStatusAppService : CrudAppService<NotificationStatus, NotificationStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateNotificationStatusDto, CreateUpdateNotificationStatusDto>, INotificationStatusAppService
{
    public NotificationStatusAppService(IRepository<NotificationStatus, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<NotificationStatus> ApplyDefaultSorting(IQueryable<NotificationStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
public class VaultRecordTypeAppService : CrudAppService<VaultRecordType, VaultRecordTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateVaultRecordTypeDto, CreateUpdateVaultRecordTypeDto>, IVaultRecordTypeAppService
{
    public VaultRecordTypeAppService(IRepository<VaultRecordType, Guid> repository) : base(repository)
    {
    }

    protected override IQueryable<VaultRecordType> ApplyDefaultSorting(IQueryable<VaultRecordType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}
