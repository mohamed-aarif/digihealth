using Volo.Abp.Identity;
using Volo.Abp.Modularity;
using Volo.Abp.TenantManagement;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpIdentityDomainModule),
    typeof(AbpTenantManagementDomainModule))]
public class IdentityServiceDomainModule : AbpModule
{
}
