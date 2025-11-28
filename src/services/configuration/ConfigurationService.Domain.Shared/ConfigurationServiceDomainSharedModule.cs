using Volo.Abp.Modularity;
using Volo.Abp.Domain;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(AbpDddDomainSharedModule))]
public class ConfigurationServiceDomainSharedModule : AbpModule
{
}
