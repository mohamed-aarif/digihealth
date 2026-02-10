using digihealth.EntityFrameworkCore;
using digihealth.EntityFrameworkCore.Data;
using Volo.Abp.Data;
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
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpDataSeedOptions>(options =>
        {
            options.Contributors.Add<TenantSampleDataSeedContributor>();
        });
    }
}
