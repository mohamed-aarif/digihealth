using IdentityService.Permissions;

namespace IdentityService.Permissions;

public static class DigiHealthIdentityPermissions
{
    public const string GroupName = IdentityServicePermissions.GroupName;

    public static class Doctors
    {
        public const string Default = IdentityServicePermissions.Doctors.Default;
        public const string Create = IdentityServicePermissions.Doctors.Create;
        public const string Edit = IdentityServicePermissions.Doctors.Edit;
        public const string Delete = IdentityServicePermissions.Doctors.Delete;
    }

    public static class Patients
    {
        public const string Default = IdentityServicePermissions.Patients.Default;
        public const string Create = IdentityServicePermissions.Patients.Create;
        public const string Edit = IdentityServicePermissions.Patients.Edit;
        public const string Delete = IdentityServicePermissions.Patients.Delete;
    }

    public static class FamilyLinks
    {
        public const string Default = IdentityServicePermissions.FamilyLinks.Default;
        public const string Create = IdentityServicePermissions.FamilyLinks.Create;
        public const string Edit = IdentityServicePermissions.FamilyLinks.Edit;
        public const string Delete = IdentityServicePermissions.FamilyLinks.Delete;
    }

    public static class DoctorPatientLinks
    {
        public const string Default = IdentityServicePermissions.DoctorPatientLinks.Default;
        public const string Create = IdentityServicePermissions.DoctorPatientLinks.Create;
        public const string Edit = IdentityServicePermissions.DoctorPatientLinks.Edit;
        public const string Delete = IdentityServicePermissions.DoctorPatientLinks.Delete;
    }

    public static class HealthPassports
    {
        public const string Default = IdentityServicePermissions.HealthPassports.Default;
        public const string Create = IdentityServicePermissions.HealthPassports.Create;
        public const string Edit = IdentityServicePermissions.HealthPassports.Edit;
        public const string Delete = IdentityServicePermissions.HealthPassports.Delete;
    }

    public static class SubscriptionPlans
    {
        public const string Default = IdentityServicePermissions.SubscriptionPlans.Default;
        public const string Create = IdentityServicePermissions.SubscriptionPlans.Create;
        public const string Edit = IdentityServicePermissions.SubscriptionPlans.Edit;
        public const string Delete = IdentityServicePermissions.SubscriptionPlans.Delete;
    }

    public static class UserSubscriptions
    {
        public const string Default = IdentityServicePermissions.UserSubscriptions.Default;
        public const string Create = IdentityServicePermissions.UserSubscriptions.Create;
        public const string Edit = IdentityServicePermissions.UserSubscriptions.Edit;
        public const string Delete = IdentityServicePermissions.UserSubscriptions.Delete;
    }

    public static class Users
    {
        public const string Default = IdentityServicePermissions.Users.Default;
    }
}
