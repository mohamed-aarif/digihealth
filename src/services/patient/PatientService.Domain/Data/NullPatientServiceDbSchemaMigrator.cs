using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace PatientService.Data;

[ExposeServices(typeof(IPatientServiceDbSchemaMigrator))]
public class NullPatientServiceDbSchemaMigrator : IPatientServiceDbSchemaMigrator, ITransientDependency
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
