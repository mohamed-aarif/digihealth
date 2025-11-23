using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Volo.Abp.Data;

namespace digihealth;

public class SwaggerClientDataSeederHostedService : IHostedService
{
    private readonly IServiceProvider _serviceProvider;

    public SwaggerClientDataSeederHostedService(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        using var scope = _serviceProvider.CreateScope();
        var dataSeeder = scope.ServiceProvider.GetRequiredService<IDataSeeder>();
        await dataSeeder.SeedAsync(new DataSeedContext(), cancellationToken);
    }

    public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;
}
