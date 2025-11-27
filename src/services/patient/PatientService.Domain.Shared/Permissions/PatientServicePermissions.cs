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

    public static class PatientMedicalSummaries
    {
        public const string Default = GroupName + ".PatientMedicalSummaries";
        public const string Create = Default + ".Create";
        public const string Update = Default + ".Update";
        public const string Delete = Default + ".Delete";
    }

    public static class PatientExternalLinks
    {
        public const string Default = GroupName + ".PatientExternalLinks";
        public const string Create = Default + ".Create";
        public const string Update = Default + ".Update";
        public const string Delete = Default + ".Delete";
    }

    public static class PatientLookups
    {
        public const string Default = GroupName + ".PatientLookups";
    }

    public static class PatientSummaries
    {
        public const string Default = GroupName + ".PatientSummaries";
    }
}
