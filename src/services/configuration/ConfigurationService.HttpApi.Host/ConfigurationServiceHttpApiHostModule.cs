using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;
using Volo.Abp;
using Volo.Abp.AspNetCore.Authentication.JwtBearer;
using Volo.Abp.AspNetCore.MultiTenancy;
using Volo.Abp.AspNetCore.Serilog;
using Volo.Abp.Autofac;
using Volo.Abp.Http.Client;
using Volo.Abp.Modularity;
using Volo.Abp.Swashbuckle;
using DigiHealth.ConfigurationService.EntityFrameworkCore;

namespace DigiHealth.ConfigurationService;

[DependsOn(
    typeof(ConfigurationServiceHttpApiModule),
    typeof(ConfigurationServiceApplicationModule),
    typeof(ConfigurationServiceEntityFrameworkCoreModule),
    typeof(AbpAutofacModule),
    typeof(AbpSwashbuckleModule),
    typeof(AbpAspNetCoreSerilogModule),
    typeof(AbpAspNetCoreMultiTenancyModule),
    typeof(AbpAspNetCoreAuthenticationJwtBearerModule))]
public class ConfigurationServiceHttpApiHostModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        ConfigureAuthentication(context, configuration);
        ConfigureRemoteServices(configuration);

        var authority = configuration["AuthServer:Authority"];
        if (string.IsNullOrWhiteSpace(authority))
        {
            authority = configuration["App:SelfUrl"] ?? "https://localhost:5005";
        }

        context.Services.AddAbpSwaggerGenWithOAuth(
            authority: authority!,
            scopes: new Dictionary<string, string> { { ConfigurationServiceRemoteServiceConsts.RemoteServiceName, "Configuration Service API" } },
            options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo { Title = "Configuration Service API", Version = "v1" });
                options.DocInclusionPredicate((docName, description) => true);
                options.CustomSchemaIds(type => type.FullName);
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
            options.SwaggerEndpoint("/swagger/v1/swagger.json", "Configuration Service API");
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
        var audience = configuration["AuthServer:Audience"] ?? ConfigurationServiceRemoteServiceConsts.RemoteServiceName;

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

    private void ConfigureRemoteServices(IConfiguration configuration)
    {
        var identityBaseUrl = configuration["RemoteServices:IdentityService:BaseUrl"];

        if (!string.IsNullOrWhiteSpace(identityBaseUrl))
        {
            Configure<AbpRemoteServiceOptions>(options =>
            {
                options.RemoteServices["IdentityService"] = new RemoteServiceConfiguration(identityBaseUrl);
            });
        }
    }
}
