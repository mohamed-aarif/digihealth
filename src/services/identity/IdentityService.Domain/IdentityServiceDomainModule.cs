using Volo.Abp.Identity;
using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceDomainSharedModule),
    typeof(AbpIdentityDomainModule)
)]
public class IdentityServiceDomainModule : AbpModule
{
}
