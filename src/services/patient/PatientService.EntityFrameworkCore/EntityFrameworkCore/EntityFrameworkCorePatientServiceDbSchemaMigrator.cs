using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using PatientService.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Uow;

namespace PatientService.EntityFrameworkCore;

[Dependency(ReplaceServices = true)]
[ExposeServices(typeof(IPatientServiceDbSchemaMigrator))]
public class EntityFrameworkCorePatientServiceDbSchemaMigrator : IPatientServiceDbSchemaMigrator
{
    private readonly IDbContextProvider<PatientServiceDbContext> _dbContextProvider;
    private readonly IUnitOfWorkManager _unitOfWorkManager;

    public EntityFrameworkCorePatientServiceDbSchemaMigrator(
        IDbContextProvider<PatientServiceDbContext> dbContextProvider,
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
