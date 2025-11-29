using Volo.Abp.Application;
using Volo.Abp.Modularity;

namespace DigiHealth.ConfigurationService;

[DependsOn(typeof(ConfigurationServiceDomainSharedModule))]
public class ConfigurationServiceApplicationContractsModule : AbpModule
{
}
