using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace IdentityService.Data;

public class NullIdentityServiceDbSchemaMigrator : IIdentityServiceDbSchemaMigrator, ITransientDependency
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
