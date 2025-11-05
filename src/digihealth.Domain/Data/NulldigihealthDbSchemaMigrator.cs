using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace digihealth.Data;

/* This is used if database provider does't define
 * IdigihealthDbSchemaMigrator implementation.
 */
public class NulldigihealthDbSchemaMigrator : IdigihealthDbSchemaMigrator, ITransientDependency
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
