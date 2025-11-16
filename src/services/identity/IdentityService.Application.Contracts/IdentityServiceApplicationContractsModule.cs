using Volo.Abp.Application;
using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpDddApplicationContractsModule),
    typeof(AbpDddApplicationModule)
)]
public class IdentityServiceApplicationContractsModule : AbpModule
{
}
