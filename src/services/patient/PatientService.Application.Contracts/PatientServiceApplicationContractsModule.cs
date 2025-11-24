using Volo.Abp.Application;
using Volo.Abp.Modularity;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceDomainSharedModule),
    typeof(AbpDddApplicationContractsModule),
    typeof(AbpDddApplicationModule))]
public class PatientServiceApplicationContractsModule : AbpModule
{
}
