using Volo.Abp.Modularity;
using Volo.Abp.PermissionManagement;
using Volo.Abp.TenantManagement;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceDomainSharedModule),
    typeof(AbpPermissionManagementDomainModule),
    typeof(AbpTenantManagementDomainModule))]
public class PatientServiceDomainModule : AbpModule
{
}
