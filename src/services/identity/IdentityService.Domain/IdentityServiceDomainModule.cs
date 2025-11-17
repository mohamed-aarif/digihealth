using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpIdentityDomainModule),
    typeof(AbpTenantManagementDomainModule))]
public class IdentityServiceDomainModule : AbpModule
{
}
