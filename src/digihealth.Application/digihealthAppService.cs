using System;
using System.Collections.Generic;
using System.Text;
using digihealth.Localization;
using Volo.Abp.Application.Services;

namespace digihealth;

/* Inherit your application services from this class.
 */
public abstract class digihealthAppService : ApplicationService
{
    protected digihealthAppService()
    {
        LocalizationResource = typeof(digihealthResource);
    }
}
