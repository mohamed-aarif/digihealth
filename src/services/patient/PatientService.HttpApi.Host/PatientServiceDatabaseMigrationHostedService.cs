using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using PatientService.Data;
using Volo.Abp.Data;

namespace PatientService;

public class PatientServiceDatabaseMigrationHostedService : IHostedService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<PatientServiceDatabaseMigrationHostedService> _logger;

    public PatientServiceDatabaseMigrationHostedService(
        IServiceProvider serviceProvider,
        ILogger<PatientServiceDatabaseMigrationHostedService> logger)
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

        var migrators = scope.ServiceProvider.GetRequiredService<IEnumerable<IPatientServiceDbSchemaMigrator>>();

        foreach (var migrator in migrators)
        {
            await migrator.MigrateAsync();
        }

        var dataSeeder = scope.ServiceProvider.GetRequiredService<IDataSeeder>();
        await dataSeeder.SeedAsync(new DataSeedContext(null));

        _logger.LogInformation("Completed PatientService database migration and seeding.");
    }
}
