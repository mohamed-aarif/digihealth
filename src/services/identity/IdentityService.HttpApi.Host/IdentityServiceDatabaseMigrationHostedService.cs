using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using IdentityService.Data;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Volo.Abp.Data;

namespace IdentityService;

public class IdentityServiceDatabaseMigrationHostedService : IHostedService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<IdentityServiceDatabaseMigrationHostedService> _logger;

    public IdentityServiceDatabaseMigrationHostedService(
        IServiceProvider serviceProvider,
        ILogger<IdentityServiceDatabaseMigrationHostedService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        await MigrateAsync();
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    private async Task MigrateAsync()
    {
        using var scope = _serviceProvider.CreateScope();

        var migrators = scope.ServiceProvider.GetRequiredService<IEnumerable<IIdentityServiceDbSchemaMigrator>>();

        foreach (var migrator in migrators)
        {
            await migrator.MigrateAsync();
        }

        var dataSeeder = scope.ServiceProvider.GetRequiredService<IDataSeeder>();
        await dataSeeder.SeedAsync(new DataSeedContext(null));

        _logger.LogInformation("Completed IdentityService database migration and seeding.");
    }
}
