using IdentityService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace IdentityService.Permissions;

public class IdentityServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var group = context.AddGroup(IdentityServicePermissions.GroupName, L("Permission:IdentityService"));

        var doctors = group.AddPermission(IdentityServicePermissions.Doctors.Default, L("Permission:Doctors"));
        doctors.AddChild(IdentityServicePermissions.Doctors.Manage, L("Permission:Doctors.Manage"));

        var patients = group.AddPermission(IdentityServicePermissions.Patients.Default, L("Permission:Patients"));
        patients.AddChild(IdentityServicePermissions.Patients.Manage, L("Permission:Patients.Manage"));

        group.AddPermission(IdentityServicePermissions.Profile.Default, L("Permission:Profile"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<IdentityServiceResource>(name);
    }
}
