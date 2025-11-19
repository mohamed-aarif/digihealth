using System;
using IdentityService.Localization;
using IdentityService.Permissions;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Identity;
using Volo.Abp.Localization;
using Volo.Abp.Modularity;
using Volo.Abp.TenantManagement;
using Volo.Abp.Timing;
using Volo.Abp.VirtualFileSystem;

namespace IdentityService;

[DependsOn(
    typeof(AbpLocalizationModule),
    typeof(AbpIdentityDomainSharedModule),
    typeof(AbpTenantManagementDomainSharedModule))]
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

        Configure<AbpPermissionOptions>(options =>
        {
            options.DefinitionProviders.Add<IdentityServicePermissionDefinitionProvider>();
        });

        Configure<AbpClockOptions>(options =>
        {
            options.Kind = DateTimeKind.Utc;
        });
    }
}
