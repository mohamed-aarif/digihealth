using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;

namespace DigiHealth.ConfigurationService.ConfigurationLookups;

public class AppointmentChannel : ConfigurationLookupBase
{
    protected AppointmentChannel()
    {
    }

    public AppointmentChannel(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class AppointmentStatus : ConfigurationLookupBase
{
    protected AppointmentStatus()
    {
    }

    public AppointmentStatus(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class ConsentPartyType : ConfigurationLookupBase
{
    protected ConsentPartyType()
    {
    }

    public ConsentPartyType(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class ConsentStatus : ConfigurationLookupBase
{
    protected ConsentStatus()
    {
    }

    public ConsentStatus(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class DayOfWeekConfig : FullAuditedAggregateRoot<Guid>
{
    [StringLength(ConfigurationLookupConsts.DayOfWeekCodeMaxLength)]
    public string Code { get; private set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.DayOfWeekNameMaxLength)]
    public string Name { get; private set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.MaxDescriptionLength)]
    public string? Description { get; private set; }

    public int SortOrder { get; private set; }

    public bool IsActive { get; private set; }

    protected DayOfWeekConfig()
    {
    }

    public DayOfWeekConfig(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id)
    {
        Code = Check.NotNullOrWhiteSpace(code, nameof(code), ConfigurationLookupConsts.DayOfWeekCodeMaxLength);
        Name = Check.NotNullOrWhiteSpace(name, nameof(name), ConfigurationLookupConsts.DayOfWeekNameMaxLength);
        Description = Check.Length(description, nameof(description), ConfigurationLookupConsts.MaxDescriptionLength, 0);
        SortOrder = sortOrder;
        IsActive = isActive;
    }

    public void UpdateDetails(string code, string name, string? description, int sortOrder, bool isActive)
    {
        Code = Check.NotNullOrWhiteSpace(code, nameof(code), ConfigurationLookupConsts.DayOfWeekCodeMaxLength);
        Name = Check.NotNullOrWhiteSpace(name, nameof(name), ConfigurationLookupConsts.DayOfWeekNameMaxLength);
        Description = Check.Length(description, nameof(description), ConfigurationLookupConsts.MaxDescriptionLength, 0);
        SortOrder = sortOrder;
        IsActive = isActive;
    }
}

public class DeviceReadingType : ConfigurationLookupBase
{
    [StringLength(ConfigurationLookupConsts.UnitMaxLength)]
    public string? Unit { get; private set; }

    protected DeviceReadingType()
    {
    }

    public DeviceReadingType(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true,
        string? unit = null)
        : base(id, code, name, description, sortOrder, isActive)
    {
        Unit = Check.Length(unit, nameof(unit), ConfigurationLookupConsts.UnitMaxLength, 0);
    }

    public void UpdateDetails(string code, string name, string? description, int sortOrder, bool isActive, string? unit)
    {
        base.UpdateDetails(code, name, description, sortOrder, isActive);
        Unit = Check.Length(unit, nameof(unit), ConfigurationLookupConsts.UnitMaxLength, 0);
    }
}

public class DeviceType : ConfigurationLookupBase
{
    protected DeviceType()
    {
    }

    public DeviceType(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class MedicationIntakeStatus : ConfigurationLookupBase
{
    protected MedicationIntakeStatus()
    {
    }

    public MedicationIntakeStatus(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class NotificationChannel : ConfigurationLookupBase
{
    protected NotificationChannel()
    {
    }

    public NotificationChannel(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class NotificationStatus : ConfigurationLookupBase
{
    protected NotificationStatus()
    {
    }

    public NotificationStatus(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class RelationshipType : ConfigurationLookupBase
{
    protected RelationshipType()
    {
    }

    public RelationshipType(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class VaultRecordType : ConfigurationLookupBase
{
    protected VaultRecordType()
    {
    }

    public VaultRecordType(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}
