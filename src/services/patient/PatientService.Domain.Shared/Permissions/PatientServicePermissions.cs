namespace PatientService.Permissions;

public static class PatientServicePermissions
{
    public const string GroupName = "PatientService";

    public static class PatientProfiles
    {
        public const string Default = GroupName + ".PatientProfiles";
        public const string Manage = Default + ".Manage";
    }

    public static class PatientMedicalSummaries
    {
        public const string Default = GroupName + ".PatientMedicalSummaries";
        public const string Manage = Default + ".Manage";
    }

    public static class PatientExternalLinks
    {
        public const string Default = GroupName + ".PatientExternalLinks";
        public const string Manage = Default + ".Manage";
    }
}
