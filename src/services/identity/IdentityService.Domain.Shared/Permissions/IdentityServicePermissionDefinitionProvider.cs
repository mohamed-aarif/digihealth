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

        var doctors = group.GetPermissionOrNull(IdentityServicePermissions.Doctors.Default)
                      ?? group.AddPermission(IdentityServicePermissions.Doctors.Default, L("Permission:Doctors"));
        _ = doctors.Children.FirstOrDefault(child => child.Name == IdentityServicePermissions.Doctors.Manage)
            ?? doctors.AddChild(IdentityServicePermissions.Doctors.Manage, L("Permission:Doctors.Manage"));

        var patients = group.GetPermissionOrNull(IdentityServicePermissions.Patients.Default)
                       ?? group.AddPermission(IdentityServicePermissions.Patients.Default, L("Permission:Patients"));
        _ = patients.Children.FirstOrDefault(child => child.Name == IdentityServicePermissions.Patients.Manage)
            ?? patients.AddChild(IdentityServicePermissions.Patients.Manage, L("Permission:Patients.Manage"));

        _ = context.GetPermissionOrNull(IdentityServicePermissions.Profile.Default)
            ?? group.AddPermission(IdentityServicePermissions.Profile.Default, L("Permission:Profile"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<IdentityServiceResource>(name);
    }
}
