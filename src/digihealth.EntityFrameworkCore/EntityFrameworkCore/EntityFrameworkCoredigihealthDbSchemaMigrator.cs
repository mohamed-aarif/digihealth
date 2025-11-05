using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using digihealth.Data;
using Volo.Abp.DependencyInjection;

namespace digihealth.EntityFrameworkCore;

public class EntityFrameworkCoredigihealthDbSchemaMigrator
    : IdigihealthDbSchemaMigrator, ITransientDependency
{
    private readonly IServiceProvider _serviceProvider;

    public EntityFrameworkCoredigihealthDbSchemaMigrator(
        IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public async Task MigrateAsync()
    {
        /* We intentionally resolve the digihealthDbContext
         * from IServiceProvider (instead of directly injecting it)
         * to properly get the connection string of the current tenant in the
         * current scope.
         */

        await _serviceProvider
            .GetRequiredService<digihealthDbContext>()
            .Database
            .MigrateAsync();
    }
}
