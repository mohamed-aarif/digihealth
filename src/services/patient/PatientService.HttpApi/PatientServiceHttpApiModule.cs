using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.AspNetCore.Mvc;
using Volo.Abp.AutoMapper;
using Volo.Abp.Modularity;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceApplicationModule),
    typeof(AbpAspNetCoreMvcModule),
    typeof(AbpAutoMapperModule))]
public class PatientServiceHttpApiModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpAspNetCoreMvcOptions>(options =>
        {
            options.ConventionalControllers.Create(typeof(PatientServiceApplicationModule).Assembly);
        });
    }
}
