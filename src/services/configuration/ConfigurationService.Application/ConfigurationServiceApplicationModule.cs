using Volo.Abp.AutoMapper;
using Volo.Abp.Modularity;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(ConfigurationServiceApplicationContractsModule),
    typeof(ConfigurationServiceDomainModule),
    typeof(AbpAutoMapperModule))]
public class ConfigurationServiceApplicationModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpAutoMapperOptions>(options =>
        {
            options.AddProfile<ConfigurationServiceApplicationAutoMapperProfile>();
        });
    }
}
