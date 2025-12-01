using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.Http.Client;
using Volo.Abp.Modularity;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(ConfigurationServiceApplicationContractsModule),
    typeof(AbpHttpClientModule))]
public class ConfigurationServiceHttpApiClientModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        context.Services.AddHttpClientProxies(
            typeof(ConfigurationServiceApplicationContractsModule).Assembly,
            ConfigurationServiceRemoteServiceConsts.RemoteServiceName);
    }
}
