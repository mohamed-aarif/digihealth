using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore.PostgreSql;
using Volo.Abp.Modularity;

namespace PatientService.EntityFrameworkCore;

[DependsOn(
    typeof(PatientServiceDomainModule),
    typeof(AbpEntityFrameworkCorePostgreSqlModule))]
public class PatientServiceEntityFrameworkCoreModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        context.Services.AddAbpDbContext<PatientServiceDbContext>(options =>
        {
            options.AddDefaultRepositories(includeAllEntities: true);
        });

        Configure<AbpDbConnectionOptions>(options =>
        {
            var defaultConnection = configuration.GetConnectionString("Default");
            if (!string.IsNullOrWhiteSpace(defaultConnection))
            {
                options.ConnectionStrings.Default = defaultConnection;
            }

            var serviceConnection = configuration.GetConnectionString(PatientServiceDbProperties.ConnectionStringName)
                ?? defaultConnection;

            if (string.IsNullOrWhiteSpace(serviceConnection))
            {
                throw new InvalidOperationException($"Connection string '{PatientServiceDbProperties.ConnectionStringName}' was not found in configuration.");
            }

            options.ConnectionStrings[PatientServiceDbProperties.ConnectionStringName] = serviceConnection;
        });

        Configure<AbpDbContextOptions>(options =>
        {
            options.Configure(configurationContext =>
            {
                var connectionString = configurationContext.ConnectionString;

                if (string.IsNullOrWhiteSpace(connectionString))
                {
                    throw new InvalidOperationException("The database connection string could not be resolved for PatientServiceDbContext.");
                }

                configurationContext.DbContextOptions.UseNpgsql(
                    connectionString,
                    npgsqlOptions =>
                    {
                        npgsqlOptions.MigrationsHistoryTable("__EFMigrationsHistory", PatientServiceDbProperties.DbSchema);
                    });
            });
        });
    }
}
