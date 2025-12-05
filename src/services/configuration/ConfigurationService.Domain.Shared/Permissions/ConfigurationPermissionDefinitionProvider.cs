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

            AddCrudPermissions(group, ConfigurationPermissions.AppointmentChannels.Default, "Permission:AppointmentChannels");
            AddCrudPermissions(group, ConfigurationPermissions.AppointmentStatuses.Default, "Permission:AppointmentStatuses");
            AddCrudPermissions(group, ConfigurationPermissions.ConsentPartyTypes.Default, "Permission:ConsentPartyTypes");
            AddCrudPermissions(group, ConfigurationPermissions.ConsentStatuses.Default, "Permission:ConsentStatuses");
            AddCrudPermissions(group, ConfigurationPermissions.DaysOfWeek.Default, "Permission:DaysOfWeek");
            AddCrudPermissions(group, ConfigurationPermissions.DeviceReadingTypes.Default, "Permission:DeviceReadingTypes");
            AddCrudPermissions(group, ConfigurationPermissions.DeviceTypes.Default, "Permission:DeviceTypes");
            AddCrudPermissions(group, ConfigurationPermissions.MedicationIntakeStatuses.Default, "Permission:MedicationIntakeStatuses");
            AddCrudPermissions(group, ConfigurationPermissions.NotificationChannels.Default, "Permission:NotificationChannels");
            AddCrudPermissions(group, ConfigurationPermissions.NotificationStatuses.Default, "Permission:NotificationStatuses");
            AddCrudPermissions(group, ConfigurationPermissions.RelationshipTypes.Default, "Permission:RelationshipTypes");
            AddCrudPermissions(group, ConfigurationPermissions.VaultRecordTypes.Default, "Permission:VaultRecordTypes");
        }

        private void AddCrudPermissions(PermissionGroupDefinition group, string defaultPermissionName, string displayNameKey)
        {
            var permission = group.GetPermissionOrNull(defaultPermissionName)
                             ?? group.AddPermission(defaultPermissionName, L(displayNameKey));

            AddChildIfNotExists(permission, defaultPermissionName + ".Manage", L(displayNameKey + ".Manage"));
            AddChildIfNotExists(permission, defaultPermissionName + ".Create", L(displayNameKey + ".Create"));
            AddChildIfNotExists(permission, defaultPermissionName + ".Edit", L(displayNameKey + ".Edit"));
            AddChildIfNotExists(permission, defaultPermissionName + ".Delete", L(displayNameKey + ".Delete"));
        }

        private static void AddChildIfNotExists(PermissionDefinition permission, string childName, LocalizableString displayName)
        {
            _ = permission.Children.FirstOrDefault(child => child.Name == childName)
                ?? permission.AddChild(childName, displayName);
        }

        private static LocalizableString L(string name)
        {
            return LocalizableString.Create<ConfigurationServiceResource>(name);
        }
    }
}
