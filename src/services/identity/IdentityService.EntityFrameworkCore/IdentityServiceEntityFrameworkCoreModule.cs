using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore.PostgreSql;
using Volo.Abp.Identity;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.Modularity;
using Volo.Abp.PermissionManagement;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;
using Volo.Abp.TenantManagement;
using Volo.Abp.TenantManagement.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

[DependsOn(
    typeof(IdentityServiceDomainModule),
    typeof(AbpEntityFrameworkCorePostgreSqlModule),
    typeof(AbpIdentityEntityFrameworkCoreModule),
    typeof(AbpPermissionManagementEntityFrameworkCoreModule),
    typeof(AbpTenantManagementEntityFrameworkCoreModule))]
public class IdentityServiceEntityFrameworkCoreModule : AbpModule
{
    public override void PreConfigureServices(ServiceConfigurationContext context)
    {
        // Ensure all ABP module tables live in the identity schema for this microservice
        AbpIdentityDbProperties.DbSchema = IdentityServiceDbProperties.DbSchema;
        AbpPermissionManagementDbProperties.DbSchema = IdentityServiceDbProperties.DbSchema;
        AbpTenantManagementDbProperties.DbSchema = IdentityServiceDbProperties.DbSchema;

        IdentityServiceEfCoreEntityExtensionMappings.Configure();
    }

    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        context.Services.AddAbpDbContext<IdentityServiceDbContext>(options =>
        {
            options.ReplaceDbContext<IIdentityDbContext>();
            options.ReplaceDbContext<IPermissionManagementDbContext>();
            options.ReplaceDbContext<ITenantManagementDbContext>();
            options.AddDefaultRepositories(includeAllEntities: true);
        });

        Configure<AbpDbConnectionOptions>(options =>
        {
            var defaultConnection = configuration.GetConnectionString("Default");
            if (!string.IsNullOrWhiteSpace(defaultConnection))
            {
                options.ConnectionStrings.Default = defaultConnection;
            }

            var identityConnection = configuration.GetConnectionString(IdentityServiceDbProperties.ConnectionStringName)
                ?? defaultConnection;

            if (string.IsNullOrWhiteSpace(identityConnection))
            {
                throw new InvalidOperationException(
                    $"Connection string '{IdentityServiceDbProperties.ConnectionStringName}' was not found in configuration.");
            }

            options.ConnectionStrings[IdentityServiceDbProperties.ConnectionStringName] = identityConnection;
        });

        Configure<AbpDbContextOptions>(options =>
        {
            options.Configure(configurationContext =>
            {
                var connectionString = configurationContext.ConnectionString;

                if (string.IsNullOrWhiteSpace(connectionString))
                {
                    throw new InvalidOperationException(
                        "The database connection string could not be resolved for IdentityServiceDbContext.");
                }

                configurationContext.DbContextOptions.UseNpgsql(
                    connectionString,
                    npgsqlOptions =>
                    {
                        // Put EF migrations history in the 'identity' schema
                        npgsqlOptions.MigrationsHistoryTable(
                            "__EFMigrationsHistory",
                            IdentityServiceDbProperties.DbSchema  // should be "identity"
                        );
                    });
            });
        });

    }
}
