namespace IdentityService.Permissions;

public static class IdentityServicePermissions
{
    public const string GroupName = "IdentityService";

    public static class Doctors
    {
        public const string Default = GroupName + ".Doctors";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class Patients
    {
        public const string Default = GroupName + ".Patients";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class FamilyLinks
    {
        public const string Default = GroupName + ".FamilyLinks";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class DoctorPatientLinks
    {
        public const string Default = GroupName + ".DoctorPatientLinks";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class HealthPassports
    {
        public const string Default = GroupName + ".HealthPassports";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class SubscriptionPlans
    {
        public const string Default = GroupName + ".SubscriptionPlans";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class UserSubscriptions
    {
        public const string Default = GroupName + ".UserSubscriptions";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class Users
    {
        public const string Default = GroupName + ".Users";
    }

    public static class Profile
    {
        public const string Default = GroupName + ".Profile";
    }
}
