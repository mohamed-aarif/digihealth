using System.Threading.Tasks;
using IdentityService.Data;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Uow;

namespace IdentityService.EntityFrameworkCore;

[Dependency(ReplaceServices = true)]
[ExposeServices(typeof(IIdentityServiceDbSchemaMigrator))]
public class EntityFrameworkCoreIdentityServiceDbSchemaMigrator : IIdentityServiceDbSchemaMigrator
{
    private readonly IDbContextProvider<IdentityServiceDbContext> _dbContextProvider;
    private readonly IUnitOfWorkManager _unitOfWorkManager;

    public EntityFrameworkCoreIdentityServiceDbSchemaMigrator(
        IDbContextProvider<IdentityServiceDbContext> dbContextProvider,
        IUnitOfWorkManager unitOfWorkManager)
    {
        _dbContextProvider = dbContextProvider;
        _unitOfWorkManager = unitOfWorkManager;
    }

    public async Task MigrateAsync()
    {
        using var uow = _unitOfWorkManager.Begin(requiresNew: true);

        var dbContext = await _dbContextProvider.GetDbContextAsync();
        await dbContext.Database.MigrateAsync();

        await uow.CompleteAsync();
    }
}
