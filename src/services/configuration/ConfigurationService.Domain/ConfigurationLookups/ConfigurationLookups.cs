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

public class DeviceType : ConfigurationLookupBase
{
    protected DeviceType()
    {
    }

    public DeviceType(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
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

public class NotificationChannel : ConfigurationLookupBase
{
    protected NotificationChannel()
    {
    }

    public NotificationChannel(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class NotificationStatus : ConfigurationLookupBase
{
    protected NotificationStatus()
    {
    }

    public NotificationStatus(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}

public class VaultRecordType : ConfigurationLookupBase
{
    protected VaultRecordType()
    {
    }

    public VaultRecordType(Guid id, string code, string name, string? description, int sortOrder, bool isActive)
        : base(id, code, name, description, sortOrder, isActive)
    {
    }
}
