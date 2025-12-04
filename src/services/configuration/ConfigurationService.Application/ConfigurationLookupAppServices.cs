using System;
using System.Linq;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using DigiHealth.ConfigurationService.Permissions;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace DigiHealth.ConfigurationService;

public abstract class ConfigurationLookupAppService<TEntity, TEntityDto, TCreateUpdateDto> : CrudAppService<TEntity, TEntityDto, Guid,
    PagedAndSortedResultRequestDto, TCreateUpdateDto, TCreateUpdateDto>
    where TEntity : ConfigurationLookupBase
{
    protected ConfigurationLookupAppService(IRepository<TEntity, Guid> repository, string permissionName)
        : base(repository)
    {
        GetPolicyName = permissionName;
        GetListPolicyName = permissionName;
        CreatePolicyName = permissionName + ".Create";
        UpdatePolicyName = permissionName + ".Edit";
        DeletePolicyName = permissionName + ".Delete";
    }

    protected override IQueryable<TEntity> ApplyDefaultSorting(IQueryable<TEntity> query)
    {
        return query.OrderBy(e => e.SortOrder).ThenBy(e => e.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.AppointmentChannels.Default)]
public class AppointmentChannelAppService : ConfigurationLookupAppService<AppointmentChannel, AppointmentChannelDto,
    CreateUpdateAppointmentChannelDto>, IAppointmentChannelAppService
{
    public AppointmentChannelAppService(IRepository<AppointmentChannel, Guid> repository)
        : base(repository, ConfigurationPermissions.AppointmentChannels.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.AppointmentStatuses.Default)]
public class AppointmentStatusAppService : ConfigurationLookupAppService<AppointmentStatus, AppointmentStatusDto,
    CreateUpdateAppointmentStatusDto>, IAppointmentStatusAppService
{
    public AppointmentStatusAppService(IRepository<AppointmentStatus, Guid> repository)
        : base(repository, ConfigurationPermissions.AppointmentStatuses.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.ConsentPartyTypes.Default)]
public class ConsentPartyTypeAppService : ConfigurationLookupAppService<ConsentPartyType, ConsentPartyTypeDto,
    CreateUpdateConsentPartyTypeDto>, IConsentPartyTypeAppService
{
    public ConsentPartyTypeAppService(IRepository<ConsentPartyType, Guid> repository)
        : base(repository, ConfigurationPermissions.ConsentPartyTypes.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.ConsentStatuses.Default)]
public class ConsentStatusAppService : ConfigurationLookupAppService<ConsentStatus, ConsentStatusDto,
    CreateUpdateConsentStatusDto>, IConsentStatusAppService
{
    public ConsentStatusAppService(IRepository<ConsentStatus, Guid> repository)
        : base(repository, ConfigurationPermissions.ConsentStatuses.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.DaysOfWeek.Default)]
public class DayOfWeekConfigAppService : CrudAppService<DayOfWeekConfig, DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateDayOfWeekConfigDto, CreateUpdateDayOfWeekConfigDto>, IDayOfWeekConfigAppService
{
    public DayOfWeekConfigAppService(IRepository<DayOfWeekConfig, Guid> repository) : base(repository)
    {
        GetPolicyName = ConfigurationPermissions.DaysOfWeek.Default;
        GetListPolicyName = ConfigurationPermissions.DaysOfWeek.Default;
        CreatePolicyName = ConfigurationPermissions.DaysOfWeek.Create;
        UpdatePolicyName = ConfigurationPermissions.DaysOfWeek.Edit;
        DeletePolicyName = ConfigurationPermissions.DaysOfWeek.Delete;
    }

    protected override IQueryable<DayOfWeekConfig> ApplyDefaultSorting(IQueryable<DayOfWeekConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.DeviceReadingTypes.Default)]
public class DeviceReadingTypeAppService : ConfigurationLookupAppService<DeviceReadingType, DeviceReadingTypeDto,
    CreateUpdateDeviceReadingTypeDto>, IDeviceReadingTypeAppService
{
    public DeviceReadingTypeAppService(IRepository<DeviceReadingType, Guid> repository)
        : base(repository, ConfigurationPermissions.DeviceReadingTypes.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.DeviceTypes.Default)]
public class DeviceTypeAppService : ConfigurationLookupAppService<DeviceType, DeviceTypeDto,
    CreateUpdateDeviceTypeDto>, IDeviceTypeAppService
{
    public DeviceTypeAppService(IRepository<DeviceType, Guid> repository)
        : base(repository, ConfigurationPermissions.DeviceTypes.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.MedicationIntakeStatuses.Default)]
public class MedicationIntakeStatusAppService : ConfigurationLookupAppService<MedicationIntakeStatus, MedicationIntakeStatusDto,
    CreateUpdateMedicationIntakeStatusDto>, IMedicationIntakeStatusAppService
{
    public MedicationIntakeStatusAppService(IRepository<MedicationIntakeStatus, Guid> repository)
        : base(repository, ConfigurationPermissions.MedicationIntakeStatuses.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.NotificationChannels.Default)]
public class NotificationChannelAppService : ConfigurationLookupAppService<NotificationChannel, NotificationChannelDto,
    CreateUpdateNotificationChannelDto>, INotificationChannelAppService
{
    public NotificationChannelAppService(IRepository<NotificationChannel, Guid> repository)
        : base(repository, ConfigurationPermissions.NotificationChannels.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.NotificationStatuses.Default)]
public class NotificationStatusAppService : ConfigurationLookupAppService<NotificationStatus, NotificationStatusDto,
    CreateUpdateNotificationStatusDto>, INotificationStatusAppService
{
    public NotificationStatusAppService(IRepository<NotificationStatus, Guid> repository)
        : base(repository, ConfigurationPermissions.NotificationStatuses.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.RelationshipTypes.Default)]
public class RelationshipTypeAppService : ConfigurationLookupAppService<RelationshipType, RelationshipTypeDto,
    CreateUpdateRelationshipTypeDto>, IRelationshipTypeAppService
{
    public RelationshipTypeAppService(IRepository<RelationshipType, Guid> repository)
        : base(repository, ConfigurationPermissions.RelationshipTypes.Default)
    {
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.VaultRecordTypes.Default)]
public class VaultRecordTypeAppService : ConfigurationLookupAppService<VaultRecordType, VaultRecordTypeDto,
    CreateUpdateVaultRecordTypeDto>, IVaultRecordTypeAppService
{
    public VaultRecordTypeAppService(IRepository<VaultRecordType, Guid> repository)
        : base(repository, ConfigurationPermissions.VaultRecordTypes.Default)
    {
    }
}
