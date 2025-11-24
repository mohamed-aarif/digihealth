using Volo.Abp.Modularity;
using Volo.Abp.TenantManagement;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceDomainSharedModule),
    typeof(AbpTenantManagementDomainModule))]
public class PatientServiceDomainModule : AbpModule
{
}
