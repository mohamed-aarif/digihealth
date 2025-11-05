using Volo.Abp.Modularity;

namespace digihealth;

[DependsOn(
    typeof(digihealthApplicationModule),
    typeof(digihealthDomainTestModule)
)]
public class digihealthApplicationTestModule : AbpModule
{

}
