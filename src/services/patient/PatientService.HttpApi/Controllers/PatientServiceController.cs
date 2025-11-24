using PatientService.Localization;
using Volo.Abp.AspNetCore.Mvc;

namespace PatientService.Controllers;

public abstract class PatientServiceController : AbpControllerBase
{
    protected PatientServiceController()
    {
        LocalizationResource = typeof(PatientServiceResource);
    }
}
