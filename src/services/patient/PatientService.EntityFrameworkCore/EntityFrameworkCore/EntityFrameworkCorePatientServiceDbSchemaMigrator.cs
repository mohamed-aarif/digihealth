using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using PatientService.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Uow;

namespace PatientService.EntityFrameworkCore;

[ExposeServices(typeof(IPatientServiceDbSchemaMigrator))]
public class EntityFrameworkCorePatientServiceDbSchemaMigrator : IPatientServiceDbSchemaMigrator, ITransientDependency
{
    private readonly PatientServiceDbContext _dbContext;
    private readonly IUnitOfWorkManager _unitOfWorkManager;
    private readonly ILogger<EntityFrameworkCorePatientServiceDbSchemaMigrator> _logger;

    public EntityFrameworkCorePatientServiceDbSchemaMigrator(
        PatientServiceDbContext dbContext,
        IUnitOfWorkManager unitOfWorkManager,
        ILogger<EntityFrameworkCorePatientServiceDbSchemaMigrator> logger)
    {
        _dbContext = dbContext;
        _unitOfWorkManager = unitOfWorkManager;
        _logger = logger;
    }

    public async Task MigrateAsync()
    {
        _logger.LogInformation("Migrating PatientService schema...");

        await _unitOfWorkManager.WithUnitOfWorkAsync(async () =>
        {
            await _dbContext.Database.MigrateAsync();
        });
    }
}
