using System.ComponentModel.DataAnnotations;

namespace DigiHealth.ConfigurationService;

public class AppointmentStatusDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateAppointmentStatusDto : ConfigurationLookupCreateUpdateDto
{
}

public class AppointmentChannelDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateAppointmentChannelDto : ConfigurationLookupCreateUpdateDto
{
}

public class ConsentPartyTypeDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateConsentPartyTypeDto : ConfigurationLookupCreateUpdateDto
{
}

public class ConsentStatusDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateConsentStatusDto : ConfigurationLookupCreateUpdateDto
{
}

public class DayOfWeekConfigDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateDayOfWeekConfigDto : IConfigurationLookupCreateUpdateDto
{
    [Required]
    [StringLength(ConfigurationLookupConsts.DayOfWeekCodeMaxLength)]
    public string Code { get; set; } = string.Empty;

    [Required]
    [StringLength(ConfigurationLookupConsts.DayOfWeekNameMaxLength)]
    public string Name { get; set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.MaxDescriptionLength)]
    public string? Description { get; set; }

    public int SortOrder { get; set; }

    public bool IsActive { get; set; }
}

public class DeviceTypeDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateDeviceTypeDto : ConfigurationLookupCreateUpdateDto
{
}

public class MedicationIntakeStatusDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateMedicationIntakeStatusDto : ConfigurationLookupCreateUpdateDto
{
}

public class NotificationChannelDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateNotificationChannelDto : ConfigurationLookupCreateUpdateDto
{
}

public class NotificationStatusDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateNotificationStatusDto : ConfigurationLookupCreateUpdateDto
{
}

public class VaultRecordTypeDto : ConfigurationLookupDtoBase
{
}

public class CreateUpdateVaultRecordTypeDto : ConfigurationLookupCreateUpdateDto
{
}
