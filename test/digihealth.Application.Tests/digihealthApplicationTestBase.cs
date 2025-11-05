using Volo.Abp.Modularity;

namespace digihealth;

public abstract class digihealthApplicationTestBase<TStartupModule> : digihealthTestBase<TStartupModule>
    where TStartupModule : IAbpModule
{

}
