using Volo.Abp.Modularity;

namespace IdentityService;

[DependsOn(typeof(IdentityServiceDomainSharedModule))]
public class IdentityServiceDomainModule : AbpModule
{
}
