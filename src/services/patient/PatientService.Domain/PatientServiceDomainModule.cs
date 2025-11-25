using Volo.Abp.Domain;
using Volo.Abp.Modularity;

namespace PatientService;

[DependsOn(
    typeof(AbpDddDomainModule),
    typeof(PatientServiceDomainSharedModule))]
public class PatientServiceDomainModule : AbpModule
{
}
