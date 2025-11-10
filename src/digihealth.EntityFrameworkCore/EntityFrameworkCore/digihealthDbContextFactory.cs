using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace digihealth.EntityFrameworkCore;

/* This class is needed for EF Core console commands
 * (like Add-Migration and Update-Database commands) */
public class digihealthDbContextFactory : IDesignTimeDbContextFactory<digihealthDbContext>
{
    static digihealthDbContextFactory()
    {
        // Make sure design-time tools (migrations, DbMigrator) also use legacy timestamp behavior
        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
    }
    public digihealthDbContext CreateDbContext(string[] args)
    {
        digihealthEfCoreEntityExtensionMappings.Configure();

        var configuration = BuildConfiguration();

        //Aarif 8/11/25: Migrating to PostgreSQL from SQL Server
        //var builder = new DbContextOptionsBuilder<digihealthDbContext>()
        //    .UseSqlServer(configuration.GetConnectionString("Default"));
        var builder = new DbContextOptionsBuilder<digihealthDbContext>().
            UseNpgsql(configuration.GetConnectionString("Default"));

        return new digihealthDbContext(builder.Options);
    }

    private static IConfigurationRoot BuildConfiguration()
    {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Path.Combine(Directory.GetCurrentDirectory(), "../digihealth.DbMigrator/"))
            .AddJsonFile("appsettings.json", optional: false);

        return builder.Build();
    }
}
