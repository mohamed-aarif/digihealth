using IdentityService;
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.Application;
using Volo.Abp.AutoMapper;
using Volo.Abp.Http.Client;
using Volo.Abp.Modularity;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceDomainModule),
    typeof(PatientServiceApplicationContractsModule),
    typeof(IdentityServiceApplicationContractsModule),
    typeof(AbpDddApplicationModule),
    typeof(AbpAutoMapperModule),
    typeof(AbpHttpClientModule))]
public class PatientServiceApplicationModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        context.Services.AddAutoMapperObjectMapper<PatientServiceApplicationModule>();

        Configure<AbpAutoMapperOptions>(options =>
        {
            options.AddMaps<PatientServiceApplicationModule>();
        });

        context.Services.AddHttpClientProxies(
            typeof(IdentityServiceApplicationContractsModule).Assembly,
            PatientServiceRemoteServiceConsts.IdentityService);
    }
}
