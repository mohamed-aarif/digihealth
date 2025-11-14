namespace IdentityService;

public static class IdentityServiceDbProperties
{
    public static string DbTablePrefix { get; set; } = string.Empty;
    public static string DbSchema { get; set; } = "identity";
    public const string ConnectionStringName = "Default";
}
