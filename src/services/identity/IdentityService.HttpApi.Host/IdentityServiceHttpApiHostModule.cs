using IdentityService.EntityFrameworkCore;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using Serilog;
using Serilog.Events;
using Serilog.Formatting.Compact;
using Volo.Abp;
using Volo.Abp.AspNetCore.Serilog;
using Volo.Abp.Autofac;
using Volo.Abp.Modularity;
using Volo.Abp.Swashbuckle;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceHttpApiModule),
    typeof(IdentityServiceApplicationModule),
    typeof(IdentityServiceEntityFrameworkCoreModule),
    typeof(AbpAutofacModule),
    typeof(AbpSwashbuckleModule)
)]
public class IdentityServiceHttpApiHostModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpSwaggerGenOptions>(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo { Title = "Identity Service API", Version = "v1" });
        });
    }

    public override void OnApplicationInitialization(ApplicationInitializationContext context)
    {
        var app = context.GetApplicationBuilder();

        app.UseCorrelationId();
        app.UseRouting();
        app.UseAuthentication();
        app.UseAbpSerilogEnrichers();
        app.UseAuthorization();
        app.UseSwagger();
        app.UseSwaggerUI(c =>
        {
            c.SwaggerEndpoint("/swagger/v1/swagger.json", "Identity Service API");
        });
        app.UseAuditing();
        app.UseConfiguredEndpoints();
    }

    public override void OnPreApplicationInitialization(ApplicationInitializationContext context)
    {
        Log.Logger = new LoggerConfiguration()
            .MinimumLevel.Override("Microsoft", LogEventLevel.Warning)
            .MinimumLevel.Override("Microsoft.EntityFrameworkCore", LogEventLevel.Warning)
            .Enrich.FromLogContext()
            .WriteTo.Console(new RenderedCompactJsonFormatter())
            .CreateLogger();
    }
}
