using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

public static class PatientServiceEfCoreEntityExtensionMappings
{
    public static void Configure()
    {
        // configure extra properties for entities from other modules if needed
        AbpEfCoreEntityExtensionMappings.Configure();
    }
}
