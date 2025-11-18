using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace IdentityService.Data;

[Dependency(TryRegister = true)]
[ExposeServices(typeof(IIdentityServiceDbSchemaMigrator))]
public class NullIdentityServiceDbSchemaMigrator : IIdentityServiceDbSchemaMigrator
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
