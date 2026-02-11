using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace AiChatBot.AdminPortal.Permissions;

public class AdminPortalPermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var group = context.AddGroup(AdminPortalPermissions.GroupName, L("Permission:AdminPortal"));

        var chatWidgetsPermission = group.AddPermission(
            AdminPortalPermissions.ChatWidgets.Default,
            L("Permission:ChatWidgets"));

        var viewPermission = chatWidgetsPermission.AddChild(
            AdminPortalPermissions.ChatWidgets.View,
            L("Permission:ChatWidgets.View"));

        viewPermission.AddChild(
            AdminPortalPermissions.ChatWidgets.Manage,
            L("Permission:ChatWidgets.Manage"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<AdminPortalResource>(name);
    }
}
