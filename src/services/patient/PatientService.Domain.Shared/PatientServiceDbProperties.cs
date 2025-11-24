namespace PatientService;

public static class PatientServiceDbProperties
{
    public static string DbTablePrefix { get; set; } = string.Empty;
    public static string DbSchema { get; set; } = "patient";
    public const string ConnectionStringName = "PatientService";
}
