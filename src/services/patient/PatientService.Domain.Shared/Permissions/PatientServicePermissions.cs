namespace PatientService.Permissions;

public static class PatientServicePermissions
{
    public const string GroupName = "PatientService";

    public static class PatientProfiles
    {
        public const string Default = GroupName + ".PatientProfiles";
        public const string Create = Default + ".Create";
        public const string Update = Default + ".Update";
        public const string Delete = Default + ".Delete";
    }

    public static class MedicalSummaries
    {
        public const string Default = GroupName + ".MedicalSummaries";
        public const string Create = Default + ".Create";
        public const string Update = Default + ".Update";
        public const string Delete = Default + ".Delete";
    }

    public static class ExternalLinks
    {
        public const string Default = GroupName + ".ExternalLinks";
        public const string Create = Default + ".Create";
        public const string Update = Default + ".Update";
        public const string Delete = Default + ".Delete";
    }
}
