using Volo.Abp.Application;
using Volo.Abp.Identity;
using Volo.Abp.Modularity;
using Volo.Abp.TenantManagement;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpDddApplicationContractsModule),
    typeof(AbpDddApplicationModule),
    typeof(AbpIdentityApplicationContractsModule),
    typeof(AbpTenantManagementApplicationContractsModule))]
public class IdentityServiceApplicationContractsModule : AbpModule
{
}
