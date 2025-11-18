using System.Threading.Tasks;
using IdentityService.Data;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

public class EntityFrameworkCoreIdentityServiceDbSchemaMigrator : IIdentityServiceDbSchemaMigrator, ITransientDependency
{
    private readonly IDbContextProvider<IdentityServiceDbContext> _dbContextProvider;

    public EntityFrameworkCoreIdentityServiceDbSchemaMigrator(
        IDbContextProvider<IdentityServiceDbContext> dbContextProvider)
    {
        _dbContextProvider = dbContextProvider;
    }

    public async Task MigrateAsync()
    {
        var dbContext = await _dbContextProvider.GetDbContextAsync();
        await dbContext.Database.MigrateAsync();
    }
}
