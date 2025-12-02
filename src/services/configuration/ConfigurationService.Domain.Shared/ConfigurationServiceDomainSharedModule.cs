using DigiHealth.ConfigurationService.Localization;
using DigiHealth.ConfigurationService.Permissions;
using Volo.Abp.Authorization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;
using Volo.Abp.Modularity;
using Volo.Abp.Validation;
using Volo.Abp.Validation.Localization;
using Volo.Abp.VirtualFileSystem;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(AbpLocalizationModule),
    typeof(AbpAuthorizationModule),
    typeof(AbpValidationModule),
    typeof(AbpVirtualFileSystemModule))]
public class ConfigurationServiceDomainSharedModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpVirtualFileSystemOptions>(options =>
        {
            options.FileSets.AddEmbedded<ConfigurationServiceDomainSharedModule>();
        });

        Configure<AbpLocalizationOptions>(options =>
        {
            options.Resources
                .Add<ConfigurationServiceResource>("en")
                .AddBaseTypes(typeof(AbpValidationResource))
                .AddVirtualJson("/Localization/ConfigurationService");
        });

        Configure<AbpPermissionOptions>(options =>
        {
            options.DefinitionProviders.Add<ConfigurationPermissionDefinitionProvider>();
        });
    }
}
