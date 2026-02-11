namespace AiChatBot.AdminPortal.Permissions;

public static class AdminPortalPermissions
{
    public const string GroupName = "AdminPortal";

    public static class ChatWidgets
    {
        public const string Default = GroupName + ".ChatWidgets";
        public const string Manage = Default + ".Manage";
        public const string View = Default + ".View";
    }
}
