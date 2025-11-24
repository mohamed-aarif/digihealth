using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

public static class PatientServiceEfCoreEntityExtensionMappings
{
    private static bool _configured;

    public static void Configure()
    {
        if (_configured)
        {
            return;
        }

        _configured = true;

        /*
         * Configure extra properties for entities from the PatientService modules
         * to tables in the database. Use this method to map these extra properties
         * to columns in database tables.
         */
    }
}
