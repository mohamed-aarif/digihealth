using System.Linq;
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

            var appointmentStatuses = group.GetPermissionOrNull(ConfigurationPermissions.AppointmentStatuses.Default)
                                   ?? group.AddPermission(ConfigurationPermissions.AppointmentStatuses.Default, L("Permission:AppointmentStatuses"));
            _ = appointmentStatuses.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.AppointmentStatuses.Manage)
                ?? appointmentStatuses.AddChild(ConfigurationPermissions.AppointmentStatuses.Manage, L("Permission:AppointmentStatuses.Manage"));

            var appointmentChannels = group.GetPermissionOrNull(ConfigurationPermissions.AppointmentChannels.Default)
                                     ?? group.AddPermission(ConfigurationPermissions.AppointmentChannels.Default, L("Permission:AppointmentChannels"));
            _ = appointmentChannels.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.AppointmentChannels.Manage)
                ?? appointmentChannels.AddChild(ConfigurationPermissions.AppointmentChannels.Manage, L("Permission:AppointmentChannels.Manage"));

            var consentPartyTypes = group.GetPermissionOrNull(ConfigurationPermissions.ConsentPartyTypes.Default)
                                    ?? group.AddPermission(ConfigurationPermissions.ConsentPartyTypes.Default, L("Permission:ConsentPartyTypes"));
            _ = consentPartyTypes.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.ConsentPartyTypes.Manage)
                ?? consentPartyTypes.AddChild(ConfigurationPermissions.ConsentPartyTypes.Manage, L("Permission:ConsentPartyTypes.Manage"));

            var consentStatuses = group.GetPermissionOrNull(ConfigurationPermissions.ConsentStatuses.Default)
                                  ?? group.AddPermission(ConfigurationPermissions.ConsentStatuses.Default, L("Permission:ConsentStatuses"));
            _ = consentStatuses.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.ConsentStatuses.Manage)
                ?? consentStatuses.AddChild(ConfigurationPermissions.ConsentStatuses.Manage, L("Permission:ConsentStatuses.Manage"));

            var daysOfWeek = group.GetPermissionOrNull(ConfigurationPermissions.DaysOfWeek.Default)
                              ?? group.AddPermission(ConfigurationPermissions.DaysOfWeek.Default, L("Permission:DaysOfWeek"));
            _ = daysOfWeek.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.DaysOfWeek.Manage)
                ?? daysOfWeek.AddChild(ConfigurationPermissions.DaysOfWeek.Manage, L("Permission:DaysOfWeek.Manage"));

            var deviceTypes = group.GetPermissionOrNull(ConfigurationPermissions.DeviceTypes.Default)
                              ?? group.AddPermission(ConfigurationPermissions.DeviceTypes.Default, L("Permission:DeviceTypes"));
            _ = deviceTypes.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.DeviceTypes.Manage)
                ?? deviceTypes.AddChild(ConfigurationPermissions.DeviceTypes.Manage, L("Permission:DeviceTypes.Manage"));

            var medicationIntakeStatuses = group.GetPermissionOrNull(ConfigurationPermissions.MedicationIntakeStatuses.Default)
                                          ?? group.AddPermission(ConfigurationPermissions.MedicationIntakeStatuses.Default, L("Permission:MedicationIntakeStatuses"));
            _ = medicationIntakeStatuses.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.MedicationIntakeStatuses.Manage)
                ?? medicationIntakeStatuses.AddChild(ConfigurationPermissions.MedicationIntakeStatuses.Manage, L("Permission:MedicationIntakeStatuses.Manage"));

            var notificationChannels = group.GetPermissionOrNull(ConfigurationPermissions.NotificationChannels.Default)
                                        ?? group.AddPermission(ConfigurationPermissions.NotificationChannels.Default, L("Permission:NotificationChannels"));
            _ = notificationChannels.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.NotificationChannels.Manage)
                ?? notificationChannels.AddChild(ConfigurationPermissions.NotificationChannels.Manage, L("Permission:NotificationChannels.Manage"));

            var notificationStatuses = group.GetPermissionOrNull(ConfigurationPermissions.NotificationStatuses.Default)
                                        ?? group.AddPermission(ConfigurationPermissions.NotificationStatuses.Default, L("Permission:NotificationStatuses"));
            _ = notificationStatuses.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.NotificationStatuses.Manage)
                ?? notificationStatuses.AddChild(ConfigurationPermissions.NotificationStatuses.Manage, L("Permission:NotificationStatuses.Manage"));

            var vaultRecordTypes = group.GetPermissionOrNull(ConfigurationPermissions.VaultRecordTypes.Default)
                                   ?? group.AddPermission(ConfigurationPermissions.VaultRecordTypes.Default, L("Permission:VaultRecordTypes"));
            _ = vaultRecordTypes.Children.FirstOrDefault(child => child.Name == ConfigurationPermissions.VaultRecordTypes.Manage)
                ?? vaultRecordTypes.AddChild(ConfigurationPermissions.VaultRecordTypes.Manage, L("Permission:VaultRecordTypes.Manage"));
        }

        private static LocalizableString L(string name)
        {
            return LocalizableString.Create<ConfigurationServiceResource>(name);
        }
    }
}
