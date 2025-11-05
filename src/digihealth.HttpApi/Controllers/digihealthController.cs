using digihealth.Localization;
using Volo.Abp.AspNetCore.Mvc;

namespace digihealth.Controllers;

/* Inherit your controllers from this class.
 */
public abstract class digihealthController : AbpControllerBase
{
    protected digihealthController()
    {
        LocalizationResource = typeof(digihealthResource);
    }
}
