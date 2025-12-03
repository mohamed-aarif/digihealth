using DigiHealth.ConfigurationService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Localization;

namespace DigiHealth.ConfigurationService.Permissions
{
    public class ConfigurationPermissionDefinitionProvider : PermissionDefinitionProvider, ITransientDependency
    {
        public override void Define(IPermissionDefinitionContext context)
        {
            var group = context.GetGroupOrNull(ConfigurationPermissions.GroupName)
                        ?? context.AddGroup(ConfigurationPermissions.GroupName, L("Permission:Configuration"));

            var appointmentStatuses = group.AddPermission(ConfigurationPermissions.AppointmentStatuses.Default, L("Permission:AppointmentStatuses"));
            appointmentStatuses.AddChild(ConfigurationPermissions.AppointmentStatuses.Manage, L("Permission:AppointmentStatuses.Manage"));

            var appointmentChannels = group.AddPermission(ConfigurationPermissions.AppointmentChannels.Default, L("Permission:AppointmentChannels"));
            appointmentChannels.AddChild(ConfigurationPermissions.AppointmentChannels.Manage, L("Permission:AppointmentChannels.Manage"));

            var consentPartyTypes = group.AddPermission(ConfigurationPermissions.ConsentPartyTypes.Default, L("Permission:ConsentPartyTypes"));
            consentPartyTypes.AddChild(ConfigurationPermissions.ConsentPartyTypes.Manage, L("Permission:ConsentPartyTypes.Manage"));

            var consentStatuses = group.AddPermission(ConfigurationPermissions.ConsentStatuses.Default, L("Permission:ConsentStatuses"));
            consentStatuses.AddChild(ConfigurationPermissions.ConsentStatuses.Manage, L("Permission:ConsentStatuses.Manage"));

            var daysOfWeek = group.AddPermission(ConfigurationPermissions.DaysOfWeek.Default, L("Permission:DaysOfWeek"));
            daysOfWeek.AddChild(ConfigurationPermissions.DaysOfWeek.Manage, L("Permission:DaysOfWeek.Manage"));

            var deviceTypes = group.AddPermission(ConfigurationPermissions.DeviceTypes.Default, L("Permission:DeviceTypes"));
            deviceTypes.AddChild(ConfigurationPermissions.DeviceTypes.Manage, L("Permission:DeviceTypes.Manage"));

            var medicationIntakeStatuses = group.AddPermission(ConfigurationPermissions.MedicationIntakeStatuses.Default, L("Permission:MedicationIntakeStatuses"));
            medicationIntakeStatuses.AddChild(ConfigurationPermissions.MedicationIntakeStatuses.Manage, L("Permission:MedicationIntakeStatuses.Manage"));

            var notificationChannels = group.AddPermission(ConfigurationPermissions.NotificationChannels.Default, L("Permission:NotificationChannels"));
            notificationChannels.AddChild(ConfigurationPermissions.NotificationChannels.Manage, L("Permission:NotificationChannels.Manage"));

            var notificationStatuses = group.AddPermission(ConfigurationPermissions.NotificationStatuses.Default, L("Permission:NotificationStatuses"));
            notificationStatuses.AddChild(ConfigurationPermissions.NotificationStatuses.Manage, L("Permission:NotificationStatuses.Manage"));

            var vaultRecordTypes = group.AddPermission(ConfigurationPermissions.VaultRecordTypes.Default, L("Permission:VaultRecordTypes"));
            vaultRecordTypes.AddChild(ConfigurationPermissions.VaultRecordTypes.Manage, L("Permission:VaultRecordTypes.Manage"));
        }

        private static LocalizableString L(string name)
        {
            return LocalizableString.Create<ConfigurationServiceResource>(name);
        }
    }
}
