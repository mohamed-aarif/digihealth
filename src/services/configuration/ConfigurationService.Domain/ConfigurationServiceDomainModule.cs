using Volo.Abp.Modularity;

namespace DigiHealth.ConfigurationService;

[DependsOn(typeof(ConfigurationServiceDomainSharedModule))]
public class ConfigurationServiceDomainModule : AbpModule
{
}
