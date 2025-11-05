using digihealth.EntityFrameworkCore;
using Volo.Abp.Autofac;
using Volo.Abp.Modularity;

namespace digihealth.DbMigrator;

[DependsOn(
    typeof(AbpAutofacModule),
    typeof(digihealthEntityFrameworkCoreModule),
    typeof(digihealthApplicationContractsModule)
    )]
public class digihealthDbMigratorModule : AbpModule
{
}
