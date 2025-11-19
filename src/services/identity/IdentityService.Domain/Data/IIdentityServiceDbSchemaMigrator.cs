using System.Threading.Tasks;

namespace IdentityService.Data;

public interface IIdentityServiceDbSchemaMigrator
{
    Task MigrateAsync();
}
