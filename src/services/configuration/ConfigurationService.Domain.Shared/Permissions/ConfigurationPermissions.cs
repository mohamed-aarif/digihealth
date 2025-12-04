namespace DigiHealth.ConfigurationService.Permissions
{
    public static class ConfigurationPermissions
    {
        public const string GroupName = "Configuration";

        public static class AppointmentStatuses
        {
            public const string Default = GroupName + ".AppointmentStatuses";
            public const string Manage = Default + ".Manage";
        }

        public static class AppointmentChannels
        {
            public const string Default = GroupName + ".AppointmentChannels";
            public const string Manage = Default + ".Manage";
        }

        public static class ConsentPartyTypes
        {
            public const string Default = GroupName + ".ConsentPartyTypes";
            public const string Manage = Default + ".Manage";
        }

        public static class ConsentStatuses
        {
            public const string Default = GroupName + ".ConsentStatuses";
            public const string Manage = Default + ".Manage";
        }

        public static class DaysOfWeek
        {
            public const string Default = GroupName + ".DaysOfWeek";
            public const string Manage = Default + ".Manage";
        }

        public static class DeviceTypes
        {
            public const string Default = GroupName + ".DeviceTypes";
            public const string Manage = Default + ".Manage";
        }

        public static class MedicationIntakeStatuses
        {
            public const string Default = GroupName + ".MedicationIntakeStatuses";
            public const string Manage = Default + ".Manage";
        }

        public static class NotificationChannels
        {
            public const string Default = GroupName + ".NotificationChannels";
            public const string Manage = Default + ".Manage";
        }

        public static class NotificationStatuses
        {
            public const string Default = GroupName + ".NotificationStatuses";
            public const string Manage = Default + ".Manage";
        }

        public static class VaultRecordTypes
        {
            public const string Default = GroupName + ".VaultRecordTypes";
            public const string Manage = Default + ".Manage";
        }
    }
}
