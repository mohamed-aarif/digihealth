using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;

namespace PatientService.EntityFrameworkCore;

public class PatientServiceDbContextFactory : IDesignTimeDbContextFactory<PatientServiceDbContext>
{
    public PatientServiceDbContext CreateDbContext(string[] args)
    {
        var configuration = BuildConfiguration();

        var connectionString = configuration.GetConnectionString(PatientServiceDbProperties.ConnectionStringName)
            ?? configuration.GetConnectionString("Default")
            ?? throw new InvalidOperationException($"Connection string '{PatientServiceDbProperties.ConnectionStringName}' was not found.");

        var builder = new DbContextOptionsBuilder<PatientServiceDbContext>()
            .UseNpgsql(connectionString);

        return new PatientServiceDbContext(builder.Options);
    }

    private static IConfigurationRoot BuildConfiguration()
    {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Path.Combine(Directory.GetCurrentDirectory(), "..", "PatientService.HttpApi.Host"))
            .AddJsonFile("appsettings.json", optional: false);

        return builder.Build();
    }
}
