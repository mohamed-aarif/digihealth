using System;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using Volo.Abp;
using Volo.Abp.AspNetCore.Authentication.JwtBearer;
using Volo.Abp.AspNetCore.MultiTenancy;
using Volo.Abp.AspNetCore.Serilog;
using Volo.Abp.Autofac;
using Volo.Abp.Modularity;
using Volo.Abp.Swashbuckle;
using PatientService.EntityFrameworkCore;

namespace PatientService;

[DependsOn(
    typeof(PatientServiceHttpApiModule),
    typeof(PatientServiceApplicationModule),
    typeof(PatientServiceEntityFrameworkCoreModule),
    typeof(AbpAutofacModule),
    typeof(AbpSwashbuckleModule),
    typeof(AbpAspNetCoreSerilogModule),
    typeof(AbpAspNetCoreMultiTenancyModule),
    typeof(AbpAspNetCoreAuthenticationJwtBearerModule))]
public class PatientServiceHttpApiHostModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        ConfigureAuthentication(context, configuration);

        context.Services.AddSwaggerGen();

        Configure<SwaggerGenOptions>(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo { Title = "Patient Service API", Version = "v1" });
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
            options.SwaggerEndpoint("/swagger/v1/swagger.json", "Patient Service API");
            options.RoutePrefix = string.Empty;
        });
        app.UseAuditing();
        app.UseConfiguredEndpoints();
    }

    private static void ConfigureAuthentication(ServiceConfigurationContext context, IConfiguration configuration)
    {
        var authority = configuration["AuthServer:Authority"];
        var requireHttps = bool.TryParse(configuration["AuthServer:RequireHttpsMetadata"], out var parsedRequireHttps)
            ? parsedRequireHttps
            : true;
        var audience = configuration["AuthServer:Audience"];

        context.Services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                if (!string.IsNullOrWhiteSpace(authority))
                {
                    options.Authority = authority;
                    options.RequireHttpsMetadata = requireHttps;
                }
                else
                {
                    options.RequireHttpsMetadata = false;
                    options.TokenValidationParameters.ValidateIssuer = false;
                    options.TokenValidationParameters.ValidateIssuerSigningKey = false;
                }

                if (!string.IsNullOrWhiteSpace(audience))
                {
                    options.Audience = audience;
                }
                else
                {
                    options.TokenValidationParameters.ValidateAudience = false;
                }
            });
    }
}
