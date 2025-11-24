using PatientService.Localization;
using Volo.Abp.Application.Services;

namespace PatientService;

public abstract class PatientServiceAppService : ApplicationService
{
    protected PatientServiceAppService()
    {
        LocalizationResource = typeof(PatientServiceResource);
        ObjectMapperContext = typeof(PatientServiceApplicationModule);
    }
}
