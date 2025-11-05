using Volo.Abp.Modularity;

namespace digihealth;

[DependsOn(
    typeof(digihealthDomainModule),
    typeof(digihealthTestBaseModule)
)]
public class digihealthDomainTestModule : AbpModule
{

}
