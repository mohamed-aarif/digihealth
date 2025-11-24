using System;
using PatientService.Localization;
using PatientService.Permissions;
using Volo.Abp.Localization;
using Volo.Abp.Modularity;
using Volo.Abp.PermissionManagement;
using Volo.Abp.TenantManagement;
using Volo.Abp.VirtualFileSystem;

namespace PatientService;

[DependsOn(
    typeof(AbpLocalizationModule),
    typeof(AbpPermissionManagementDomainSharedModule),
    typeof(AbpTenantManagementDomainSharedModule))]
public class PatientServiceDomainSharedModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpVirtualFileSystemOptions>(options =>
        {
            options.FileSets.AddEmbedded<PatientServiceDomainSharedModule>();
        });

        Configure<AbpLocalizationOptions>(options =>
        {
            options.Resources
                .Add<PatientServiceResource>("en")
                .AddVirtualJson("/Localization/PatientService");
        });

        Configure<AbpPermissionOptions>(options =>
        {
            options.DefinitionProviders.Add<PatientServicePermissionDefinitionProvider>();
        });
    }
}
