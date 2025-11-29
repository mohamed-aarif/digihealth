using System;

namespace DigiHealth.ConfigurationService.ConfigurationLookups;

public class AppointmentStatus : ConfigurationLookupBase
{
    protected AppointmentStatus()
    {
    }

    public AppointmentStatus(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class AppointmentChannel : ConfigurationLookupBase
{
    protected AppointmentChannel()
    {
    }

    public AppointmentChannel(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class ConsentPartyType : ConfigurationLookupBase
{
    protected ConsentPartyType()
    {
    }

    public ConsentPartyType(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class ConsentStatus : ConfigurationLookupBase
{
    protected ConsentStatus()
    {
    }

    public ConsentStatus(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class DayOfWeekConfig : ConfigurationLookupBase
{
    protected DayOfWeekConfig()
    {
    }

    public DayOfWeekConfig(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class DeviceTypeConfig : ConfigurationLookupBase
{
    protected DeviceTypeConfig()
    {
    }

    public DeviceTypeConfig(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class MedicationIntakeStatus : ConfigurationLookupBase
{
    protected MedicationIntakeStatus()
    {
    }

    public MedicationIntakeStatus(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class NotificationChannelConfig : ConfigurationLookupBase
{
    protected NotificationChannelConfig()
    {
    }

    public NotificationChannelConfig(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class NotificationStatusConfig : ConfigurationLookupBase
{
    protected NotificationStatusConfig()
    {
    }

    public NotificationStatusConfig(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class VaultRecordTypeConfig : ConfigurationLookupBase
{
    protected VaultRecordTypeConfig()
    {
    }

    public VaultRecordTypeConfig(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}
