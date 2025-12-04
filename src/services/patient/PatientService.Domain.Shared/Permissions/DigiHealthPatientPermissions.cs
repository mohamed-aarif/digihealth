namespace PatientService.Permissions;

public static class DigiHealthPatientPermissions
{
    public const string GroupName = "PatientService";

    public static class PatientProfileExtensions
    {
        public const string Default = GroupName + ".PatientProfileExtensions";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class PatientMedicalSummaries
    {
        public const string Default = GroupName + ".PatientMedicalSummaries";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class PatientExternalLinks
    {
        public const string Default = GroupName + ".PatientExternalLinks";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class Meals
    {
        public const string Default = GroupName + ".Meals";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }

    public static class MealItems
    {
        public const string Default = GroupName + ".MealItems";
        public const string Create = Default + ".Create";
        public const string Edit = Default + ".Edit";
        public const string Delete = Default + ".Delete";
    }
}
