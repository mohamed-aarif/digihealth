using System;
using IdentityService.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using Volo.Abp;
using Volo.Abp.AspNetCore.Authentication.JwtBearer;
using Volo.Abp.AspNetCore.MultiTenancy;
using Volo.Abp.Autofac;
using Volo.Abp.Modularity;
using Volo.Abp.Swashbuckle;
using Volo.Abp.AspNetCore.Serilog;

namespace IdentityService;

[DependsOn(
    typeof(IdentityServiceHttpApiModule),
    typeof(IdentityServiceApplicationModule),
    typeof(IdentityServiceEntityFrameworkCoreModule),
    typeof(AbpAutofacModule),
    typeof(AbpSwashbuckleModule),
    typeof(AbpAspNetCoreSerilogModule),
    typeof(AbpAspNetCoreMultiTenancyModule),
    typeof(AbpAspNetCoreAuthenticationJwtBearerModule)
)]
public class IdentityServiceHttpApiHostModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        ConfigureAuthentication(context, configuration);

        context.Services.AddSwaggerGen();

        Configure<SwaggerGenOptions>(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo { Title = "Identity Service API", Version = "v1" });
            options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                Description = "JWT Authorization header using the Bearer scheme. Example: 'Bearer 12345abcdef'",
                Name = "Authorization",
                In = ParameterLocation.Header,
                Type = SecuritySchemeType.Http,
                Scheme = "bearer",
                BearerFormat = "JWT"
            });
            options.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecurityScheme
                    {
                        Reference = new OpenApiReference
                        {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                        }
                    },
                    Array.Empty<string>()
                }
            });
        });
    }

    public override void OnApplicationInitialization(ApplicationInitializationContext context)
    {
        var app = context.GetApplicationBuilder();

        app.UseCorrelationId();
        app.UseRouting();
        app.UseMultiTenancy();
        app.UseAuthentication();
        app.UseAbpSerilogEnrichers();
        app.UseAuthorization();
        app.UseSwagger();
        app.UseSwaggerUI(options =>
        {
            options.SwaggerEndpoint("/swagger/v1/swagger.json", "Identity Service API");
            options.RoutePrefix = string.Empty;
        });
        app.UseAuditing();
        app.UseConfiguredEndpoints();
    }

    private static void ConfigureAuthentication(ServiceConfigurationContext context, IConfiguration configuration)
    {
        context.Services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                options.Authority = configuration["AuthServer:Authority"] ?? configuration["App:SelfUrl"];
                options.RequireHttpsMetadata = bool.TryParse(configuration["AuthServer:RequireHttpsMetadata"], out var requireHttps)
                    ? requireHttps
                    : false;
                options.Audience = configuration["AuthServer:Audience"] ?? "IdentityService";
            });
    }
}
