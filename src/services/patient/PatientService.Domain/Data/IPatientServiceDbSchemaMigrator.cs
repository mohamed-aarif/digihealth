using System.Threading.Tasks;

namespace PatientService.Data;

public interface IPatientServiceDbSchemaMigrator
{
    Task MigrateAsync();
}
