using digihealth.Localization;
using Volo.Abp.AspNetCore.Components;

namespace digihealth.Blazor.Client;

public abstract class digihealthComponentBase : AbpComponentBase
{
    protected digihealthComponentBase()
    {
        LocalizationResource = typeof(digihealthResource);
    }
}
