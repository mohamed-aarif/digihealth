using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;

namespace IdentityService.EntityFrameworkCore;

public class IdentityServiceDbContextFactory : IDesignTimeDbContextFactory<IdentityServiceDbContext>
{
    public IdentityServiceDbContext CreateDbContext(string[] args)
    {
        var configuration = BuildConfiguration();

        var connectionString = configuration.GetConnectionString(IdentityServiceDbProperties.ConnectionStringName)
            ?? configuration.GetConnectionString("IdentityService")
            ?? throw new InvalidOperationException(
                $"Connection string '{IdentityServiceDbProperties.ConnectionStringName}' was not found.");

        var builder = new DbContextOptionsBuilder<IdentityServiceDbContext>()
            .UseNpgsql(connectionString);

        return new IdentityServiceDbContext(builder.Options);
    }

    private static IConfigurationRoot BuildConfiguration()
    {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Path.Combine(Directory.GetCurrentDirectory(), "..", "IdentityService.HttpApi.Host"))
            .AddJsonFile("appsettings.json", optional: false);

        return builder.Build();
    }
}
