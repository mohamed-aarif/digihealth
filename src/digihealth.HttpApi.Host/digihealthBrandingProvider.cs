using Microsoft.Extensions.Localization;
using digihealth.Localization;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Ui.Branding;

namespace digihealth;

[Dependency(ReplaceServices = true)]
public class digihealthBrandingProvider : DefaultBrandingProvider
{
    private IStringLocalizer<digihealthResource> _localizer;

    public digihealthBrandingProvider(IStringLocalizer<digihealthResource> localizer)
    {
        _localizer = localizer;
    }

    public override string AppName => _localizer["AppName"];
}
