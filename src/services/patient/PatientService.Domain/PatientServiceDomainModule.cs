using Volo.Abp.Modularity;

namespace PatientService;

[DependsOn(typeof(PatientServiceDomainSharedModule))]
public class PatientServiceDomainModule : AbpModule
{
}
