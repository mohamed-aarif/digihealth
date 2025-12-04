namespace PatientService.Permissions;

public static class PatientServicePermissions
{
    public const string GroupName = DigiHealthPatientPermissions.GroupName;

    public static class PatientProfiles
    {
        public const string Default = DigiHealthPatientPermissions.PatientProfileExtensions.Default;
        public const string Create = DigiHealthPatientPermissions.PatientProfileExtensions.Create;
        public const string Update = DigiHealthPatientPermissions.PatientProfileExtensions.Edit;
        public const string Delete = DigiHealthPatientPermissions.PatientProfileExtensions.Delete;
    }

    public static class PatientMedicalSummaries
    {
        public const string Default = DigiHealthPatientPermissions.PatientMedicalSummaries.Default;
        public const string Create = DigiHealthPatientPermissions.PatientMedicalSummaries.Create;
        public const string Update = DigiHealthPatientPermissions.PatientMedicalSummaries.Edit;
        public const string Delete = DigiHealthPatientPermissions.PatientMedicalSummaries.Delete;
    }

    public static class PatientExternalLinks
    {
        public const string Default = DigiHealthPatientPermissions.PatientExternalLinks.Default;
        public const string Create = DigiHealthPatientPermissions.PatientExternalLinks.Create;
        public const string Update = DigiHealthPatientPermissions.PatientExternalLinks.Edit;
        public const string Delete = DigiHealthPatientPermissions.PatientExternalLinks.Delete;
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
