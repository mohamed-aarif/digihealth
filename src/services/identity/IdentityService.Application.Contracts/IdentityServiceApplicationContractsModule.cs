using Volo.Abp.Application;
using Volo.Abp.Ddd.Application;
using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpDddApplicationModule)
)]
public class IdentityServiceApplicationContractsModule : AbpModule
{
}
