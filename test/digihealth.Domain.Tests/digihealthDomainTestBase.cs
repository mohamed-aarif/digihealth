using Volo.Abp.Modularity;

namespace digihealth;

/* Inherit from this class for your domain layer tests. */
public abstract class digihealthDomainTestBase<TStartupModule> : digihealthTestBase<TStartupModule>
    where TStartupModule : IAbpModule
{

}
