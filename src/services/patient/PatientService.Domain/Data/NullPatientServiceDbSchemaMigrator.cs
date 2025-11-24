using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace PatientService.Data;

public class NullPatientServiceDbSchemaMigrator : IPatientServiceDbSchemaMigrator, ITransientDependency
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
