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

            var appointmentStatuses = GetOrAddPermission(context, group,
                ConfigurationPermissions.AppointmentStatuses.Default,
                L("Permission:AppointmentStatuses"));
            AddChildIfMissing(context, appointmentStatuses,
                ConfigurationPermissions.AppointmentStatuses.Manage,
                L("Permission:AppointmentStatuses.Manage"));

            var appointmentChannels = GetOrAddPermission(context, group,
                ConfigurationPermissions.AppointmentChannels.Default,
                L("Permission:AppointmentChannels"));
            AddChildIfMissing(context, appointmentChannels,
                ConfigurationPermissions.AppointmentChannels.Manage,
                L("Permission:AppointmentChannels.Manage"));

            var consentPartyTypes = GetOrAddPermission(context, group,
                ConfigurationPermissions.ConsentPartyTypes.Default,
                L("Permission:ConsentPartyTypes"));
            AddChildIfMissing(context, consentPartyTypes,
                ConfigurationPermissions.ConsentPartyTypes.Manage,
                L("Permission:ConsentPartyTypes.Manage"));

            var consentStatuses = GetOrAddPermission(context, group,
                ConfigurationPermissions.ConsentStatuses.Default,
                L("Permission:ConsentStatuses"));
            AddChildIfMissing(context, consentStatuses,
                ConfigurationPermissions.ConsentStatuses.Manage,
                L("Permission:ConsentStatuses.Manage"));

            var daysOfWeek = GetOrAddPermission(context, group,
                ConfigurationPermissions.DaysOfWeek.Default,
                L("Permission:DaysOfWeek"));
            AddChildIfMissing(context, daysOfWeek,
                ConfigurationPermissions.DaysOfWeek.Manage,
                L("Permission:DaysOfWeek.Manage"));

            var deviceTypes = GetOrAddPermission(context, group,
                ConfigurationPermissions.DeviceTypes.Default,
                L("Permission:DeviceTypes"));
            AddChildIfMissing(context, deviceTypes,
                ConfigurationPermissions.DeviceTypes.Manage,
                L("Permission:DeviceTypes.Manage"));

            var medicationIntakeStatuses = GetOrAddPermission(context, group,
                ConfigurationPermissions.MedicationIntakeStatuses.Default,
                L("Permission:MedicationIntakeStatuses"));
            AddChildIfMissing(context, medicationIntakeStatuses,
                ConfigurationPermissions.MedicationIntakeStatuses.Manage,
                L("Permission:MedicationIntakeStatuses.Manage"));

            var notificationChannels = GetOrAddPermission(context, group,
                ConfigurationPermissions.NotificationChannels.Default,
                L("Permission:NotificationChannels"));
            AddChildIfMissing(context, notificationChannels,
                ConfigurationPermissions.NotificationChannels.Manage,
                L("Permission:NotificationChannels.Manage"));

            var notificationStatuses = GetOrAddPermission(context, group,
                ConfigurationPermissions.NotificationStatuses.Default,
                L("Permission:NotificationStatuses"));
            AddChildIfMissing(context, notificationStatuses,
                ConfigurationPermissions.NotificationStatuses.Manage,
                L("Permission:NotificationStatuses.Manage"));

            var vaultRecordTypes = GetOrAddPermission(context, group,
                ConfigurationPermissions.VaultRecordTypes.Default,
                L("Permission:VaultRecordTypes"));
            AddChildIfMissing(context, vaultRecordTypes,
                ConfigurationPermissions.VaultRecordTypes.Manage,
                L("Permission:VaultRecordTypes.Manage"));
        }

        private static PermissionDefinition GetOrAddPermission(
            IPermissionDefinitionContext context,
            PermissionGroupDefinition group,
            string name,
            LocalizableString displayName)
        {
            return context.GetPermissionOrNull(name)
                   ?? group.GetPermissionOrNull(name)
                   ?? group.AddPermission(name, displayName);
        }

        private static PermissionDefinition AddChildIfMissing(
            IPermissionDefinitionContext context,
            PermissionDefinition parent,
            string name,
            LocalizableString displayName)
        {
            var existing = context.GetPermissionOrNull(name) ?? parent.Children.FirstOrDefault(child => child.Name == name);
            return existing ?? parent.AddChild(name, displayName);
        }

        private static LocalizableString L(string name)
        {
            return LocalizableString.Create<ConfigurationServiceResource>(name);
        }
    }
}
