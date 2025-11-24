using Volo.Abp;
using Volo.Abp.ObjectExtending;

namespace PatientService;

public static class PatientServiceModuleExtensionConfigurator
{
    public static void Configure()
    {
        // Define module entity extension mappings here when integrating with other services.
        ModuleExtensionConfigurationHelper.ApplyEntityConfigurations();
    }
}
