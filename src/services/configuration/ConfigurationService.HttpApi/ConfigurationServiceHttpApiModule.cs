using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.AspNetCore.Mvc;
using Volo.Abp.Modularity;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(ConfigurationServiceApplicationModule),
    typeof(AbpAspNetCoreMvcModule))]
public class ConfigurationServiceHttpApiModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpAspNetCoreMvcOptions>(options =>
        {
            options.ConventionalControllers.Create(typeof(ConfigurationServiceApplicationModule).Assembly, opts =>
            {
                opts.RootPath = "configuration";
            });
        });
    }
}
