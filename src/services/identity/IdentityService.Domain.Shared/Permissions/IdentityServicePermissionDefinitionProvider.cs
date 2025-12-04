using System.Linq;
using IdentityService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace IdentityService.Permissions;

public class IdentityServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var group = context.GetGroupOrNull(IdentityServicePermissions.GroupName)
                    ?? context.AddGroup(IdentityServicePermissions.GroupName, L("Permission:IdentityService"));

        AddCrudPermissions(group, IdentityServicePermissions.Doctors.Default, "Permission:Doctors",
            IdentityServicePermissions.Doctors.Create,
            IdentityServicePermissions.Doctors.Edit,
            IdentityServicePermissions.Doctors.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.Patients.Default, "Permission:Patients",
            IdentityServicePermissions.Patients.Create,
            IdentityServicePermissions.Patients.Edit,
            IdentityServicePermissions.Patients.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.FamilyLinks.Default, "Permission:FamilyLinks",
            IdentityServicePermissions.FamilyLinks.Create,
            IdentityServicePermissions.FamilyLinks.Edit,
            IdentityServicePermissions.FamilyLinks.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.DoctorPatientLinks.Default, "Permission:DoctorPatientLinks",
            IdentityServicePermissions.DoctorPatientLinks.Create,
            IdentityServicePermissions.DoctorPatientLinks.Edit,
            IdentityServicePermissions.DoctorPatientLinks.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.HealthPassports.Default, "Permission:HealthPassports",
            IdentityServicePermissions.HealthPassports.Create,
            IdentityServicePermissions.HealthPassports.Edit,
            IdentityServicePermissions.HealthPassports.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.SubscriptionPlans.Default, "Permission:SubscriptionPlans",
            IdentityServicePermissions.SubscriptionPlans.Create,
            IdentityServicePermissions.SubscriptionPlans.Edit,
            IdentityServicePermissions.SubscriptionPlans.Delete);

        AddCrudPermissions(group, IdentityServicePermissions.UserSubscriptions.Default, "Permission:UserSubscriptions",
            IdentityServicePermissions.UserSubscriptions.Create,
            IdentityServicePermissions.UserSubscriptions.Edit,
            IdentityServicePermissions.UserSubscriptions.Delete);

        _ = group.GetPermissionOrNull(IdentityServicePermissions.Users.Default)
            ?? group.AddPermission(IdentityServicePermissions.Users.Default, L("Permission:Users"));

        _ = group.GetPermissionOrNull(IdentityServicePermissions.Profile.Default)
            ?? group.AddPermission(IdentityServicePermissions.Profile.Default, L("Permission:Profile"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<IdentityServiceResource>(name);
    }

    private static void AddCrudPermissions(PermissionGroupDefinition group, string defaultName, string displayNameKey,
        string create, string edit, string delete)
    {
        var permission = group.GetPermissionOrNull(defaultName) ?? group.AddPermission(defaultName, L(displayNameKey));
        _ = permission.Children.FirstOrDefault(child => child.Name == create) ?? permission.AddChild(create, L(displayNameKey + ".Create"));
        _ = permission.Children.FirstOrDefault(child => child.Name == edit) ?? permission.AddChild(edit, L(displayNameKey + ".Edit"));
        _ = permission.Children.FirstOrDefault(child => child.Name == delete) ?? permission.AddChild(delete, L(displayNameKey + ".Delete"));
    }
}
