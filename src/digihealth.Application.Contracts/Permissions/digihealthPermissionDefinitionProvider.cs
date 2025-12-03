using digihealth.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace digihealth.Permissions;

public class digihealthPermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var myGroup = context.GetGroupOrNull(digihealthPermissions.GroupName)
                      ?? context.AddGroup(digihealthPermissions.GroupName);
        //Define your own permissions here. Example:
        //myGroup.AddPermission(digihealthPermissions.MyPermission1, L("Permission:MyPermission1"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<digihealthResource>(name);
    }
}
