using System;
using System.Linq;
using System.Threading.Tasks;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using DigiHealth.ConfigurationService.Permissions;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace DigiHealth.ConfigurationService;

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.AppointmentStatuses.Default)]
public class AppointmentStatusAppService : CrudAppService<AppointmentStatus, AppointmentStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateAppointmentStatusDto, CreateUpdateAppointmentStatusDto>, IAppointmentStatusAppService
{
    public AppointmentStatusAppService(IRepository<AppointmentStatus, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.AppointmentStatuses.Manage)]
    public override Task<AppointmentStatusDto> CreateAsync(CreateUpdateAppointmentStatusDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.AppointmentStatuses.Manage)]
    public override Task<AppointmentStatusDto> UpdateAsync(Guid id, CreateUpdateAppointmentStatusDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.AppointmentStatuses.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<AppointmentStatus> ApplyDefaultSorting(IQueryable<AppointmentStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.AppointmentChannels.Default)]
public class AppointmentChannelAppService : CrudAppService<AppointmentChannel, AppointmentChannelDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateAppointmentChannelDto, CreateUpdateAppointmentChannelDto>, IAppointmentChannelAppService
{
    public AppointmentChannelAppService(IRepository<AppointmentChannel, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.AppointmentChannels.Manage)]
    public override Task<AppointmentChannelDto> CreateAsync(CreateUpdateAppointmentChannelDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.AppointmentChannels.Manage)]
    public override Task<AppointmentChannelDto> UpdateAsync(Guid id, CreateUpdateAppointmentChannelDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.AppointmentChannels.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<AppointmentChannel> ApplyDefaultSorting(IQueryable<AppointmentChannel> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.ConsentPartyTypes.Default)]
public class ConsentPartyTypeAppService : CrudAppService<ConsentPartyType, ConsentPartyTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateConsentPartyTypeDto, CreateUpdateConsentPartyTypeDto>, IConsentPartyTypeAppService
{
    public ConsentPartyTypeAppService(IRepository<ConsentPartyType, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.ConsentPartyTypes.Manage)]
    public override Task<ConsentPartyTypeDto> CreateAsync(CreateUpdateConsentPartyTypeDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.ConsentPartyTypes.Manage)]
    public override Task<ConsentPartyTypeDto> UpdateAsync(Guid id, CreateUpdateConsentPartyTypeDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.ConsentPartyTypes.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<ConsentPartyType> ApplyDefaultSorting(IQueryable<ConsentPartyType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.ConsentStatuses.Default)]
public class ConsentStatusAppService : CrudAppService<ConsentStatus, ConsentStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateConsentStatusDto, CreateUpdateConsentStatusDto>, IConsentStatusAppService
{
    public ConsentStatusAppService(IRepository<ConsentStatus, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.ConsentStatuses.Manage)]
    public override Task<ConsentStatusDto> CreateAsync(CreateUpdateConsentStatusDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.ConsentStatuses.Manage)]
    public override Task<ConsentStatusDto> UpdateAsync(Guid id, CreateUpdateConsentStatusDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.ConsentStatuses.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<ConsentStatus> ApplyDefaultSorting(IQueryable<ConsentStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.DaysOfWeek.Default)]
public class DayOfWeekConfigAppService : CrudAppService<DayOfWeekConfig, DayOfWeekConfigDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateDayOfWeekConfigDto, CreateUpdateDayOfWeekConfigDto>, IDayOfWeekConfigAppService
{
    public DayOfWeekConfigAppService(IRepository<DayOfWeekConfig, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.DaysOfWeek.Manage)]
    public override Task<DayOfWeekConfigDto> CreateAsync(CreateUpdateDayOfWeekConfigDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.DaysOfWeek.Manage)]
    public override Task<DayOfWeekConfigDto> UpdateAsync(Guid id, CreateUpdateDayOfWeekConfigDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.DaysOfWeek.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<DayOfWeekConfig> ApplyDefaultSorting(IQueryable<DayOfWeekConfig> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.DeviceTypes.Default)]
public class DeviceTypeAppService : CrudAppService<DeviceType, DeviceTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateDeviceTypeDto, CreateUpdateDeviceTypeDto>, IDeviceTypeAppService
{
    public DeviceTypeAppService(IRepository<DeviceType, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.DeviceTypes.Manage)]
    public override Task<DeviceTypeDto> CreateAsync(CreateUpdateDeviceTypeDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.DeviceTypes.Manage)]
    public override Task<DeviceTypeDto> UpdateAsync(Guid id, CreateUpdateDeviceTypeDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.DeviceTypes.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<DeviceType> ApplyDefaultSorting(IQueryable<DeviceType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.MedicationIntakeStatuses.Default)]
public class MedicationIntakeStatusAppService : CrudAppService<MedicationIntakeStatus, MedicationIntakeStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateMedicationIntakeStatusDto, CreateUpdateMedicationIntakeStatusDto>, IMedicationIntakeStatusAppService
{
    public MedicationIntakeStatusAppService(IRepository<MedicationIntakeStatus, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.MedicationIntakeStatuses.Manage)]
    public override Task<MedicationIntakeStatusDto> CreateAsync(CreateUpdateMedicationIntakeStatusDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.MedicationIntakeStatuses.Manage)]
    public override Task<MedicationIntakeStatusDto> UpdateAsync(Guid id, CreateUpdateMedicationIntakeStatusDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.MedicationIntakeStatuses.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<MedicationIntakeStatus> ApplyDefaultSorting(IQueryable<MedicationIntakeStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.NotificationChannels.Default)]
public class NotificationChannelAppService : CrudAppService<NotificationChannel, NotificationChannelDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateNotificationChannelDto, CreateUpdateNotificationChannelDto>, INotificationChannelAppService
{
    public NotificationChannelAppService(IRepository<NotificationChannel, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.NotificationChannels.Manage)]
    public override Task<NotificationChannelDto> CreateAsync(CreateUpdateNotificationChannelDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.NotificationChannels.Manage)]
    public override Task<NotificationChannelDto> UpdateAsync(Guid id, CreateUpdateNotificationChannelDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.NotificationChannels.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<NotificationChannel> ApplyDefaultSorting(IQueryable<NotificationChannel> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.NotificationStatuses.Default)]
public class NotificationStatusAppService : CrudAppService<NotificationStatus, NotificationStatusDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateNotificationStatusDto, CreateUpdateNotificationStatusDto>, INotificationStatusAppService
{
    public NotificationStatusAppService(IRepository<NotificationStatus, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.NotificationStatuses.Manage)]
    public override Task<NotificationStatusDto> CreateAsync(CreateUpdateNotificationStatusDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.NotificationStatuses.Manage)]
    public override Task<NotificationStatusDto> UpdateAsync(Guid id, CreateUpdateNotificationStatusDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.NotificationStatuses.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<NotificationStatus> ApplyDefaultSorting(IQueryable<NotificationStatus> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}

[RemoteService(Name = ConfigurationServiceRemoteServiceConsts.RemoteServiceName)]
[Authorize(ConfigurationPermissions.VaultRecordTypes.Default)]
public class VaultRecordTypeAppService : CrudAppService<VaultRecordType, VaultRecordTypeDto, Guid, PagedAndSortedResultRequestDto,
    CreateUpdateVaultRecordTypeDto, CreateUpdateVaultRecordTypeDto>, IVaultRecordTypeAppService
{
    public VaultRecordTypeAppService(IRepository<VaultRecordType, Guid> repository) : base(repository)
    {
    }

    [Authorize(ConfigurationPermissions.VaultRecordTypes.Manage)]
    public override Task<VaultRecordTypeDto> CreateAsync(CreateUpdateVaultRecordTypeDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(ConfigurationPermissions.VaultRecordTypes.Manage)]
    public override Task<VaultRecordTypeDto> UpdateAsync(Guid id, CreateUpdateVaultRecordTypeDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(ConfigurationPermissions.VaultRecordTypes.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    protected override IQueryable<VaultRecordType> ApplyDefaultSorting(IQueryable<VaultRecordType> query)
    {
        return query.OrderBy(x => x.SortOrder).ThenBy(x => x.Name);
    }
}
