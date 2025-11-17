namespace IdentityService.Permissions;

public static class IdentityServicePermissions
{
    public const string GroupName = "IdentityService";

    public static class Doctors
    {
        public const string Default = GroupName + ".Doctors";
        public const string Manage = Default + ".Manage";
    }

    public static class Patients
    {
        public const string Default = GroupName + ".Patients";
        public const string Manage = Default + ".Manage";
    }

    public static class Profile
    {
        public const string Default = GroupName + ".Profile";
    }
}
