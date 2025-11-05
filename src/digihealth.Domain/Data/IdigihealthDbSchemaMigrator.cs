using System.Threading.Tasks;

namespace digihealth.Data;

public interface IdigihealthDbSchemaMigrator
{
    Task MigrateAsync();
}
