using Volo.Abp.Localization;
using Volo.Abp.Modularity;
using Volo.Abp.VirtualFileSystem;

namespace IdentityService;

[DependsOn(typeof(AbpLocalizationModule))]
public class IdentityServiceDomainSharedModule : AbpModule
{
    public override void PreConfigureServices(ServiceConfigurationContext context)
    {
        IdentityServiceGlobalFeatureConfigurator.Configure();
        IdentityServiceModuleExtensionConfigurator.Configure();
    }

    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpVirtualFileSystemOptions>(options =>
        {
            options.FileSets.AddEmbedded<IdentityServiceDomainSharedModule>();
        });

        Configure<AbpLocalizationOptions>(options =>
        {
            options.Resources
                .Add<IdentityServiceResource>("en")
                .AddVirtualJson("/Localization/IdentityService");
        });
    }
}
