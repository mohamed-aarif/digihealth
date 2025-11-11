using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.AspNetCore.Mvc;
using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceApplicationModule),
    typeof(AbpAspNetCoreMvcModule)
)]
public class IdentityServiceHttpApiModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpAspNetCoreMvcOptions>(options =>
        {
            options.ConventionalControllers.Create(typeof(IdentityServiceApplicationModule).Assembly);
        });
    }
}
