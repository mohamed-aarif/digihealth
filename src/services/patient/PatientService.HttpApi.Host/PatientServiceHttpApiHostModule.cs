using System;
using System.Collections.Generic;
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
using Volo.Abp.Http.Client;
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
        ConfigureRemoteServices(configuration);

        var authority = configuration["AuthServer:Authority"];
        if (string.IsNullOrWhiteSpace(authority))
        {
            authority = configuration["App:SelfUrl"] ?? "https://localhost:5004";
        }

        //context.Services.AddAbpSwaggerGenWithOAuth(
        //    authority: authority,
        //    scopes: new Dictionary<string, string> { { "PatientService", "Patient Service API" } },
        //    options =>
        //    {
        //        options.SwaggerDoc("v1", new OpenApiInfo { Title = "Patient Service API", Version = "v1" });
        //        options.DocInclusionPredicate((docName, description) => true);
        //        options.CustomSchemaIds(type => type.FullName);
        //    });

        // Use "digihealth" as the scope name to be consistent across services
        context.Services.AddAbpSwaggerGenWithOAuth(
            authority: authority,
            scopes: new Dictionary<string, string>
            {
                { "digihealth", "DigiHealth API" },
                { "openid", "OpenID" },
                { "profile", "User profile" },
                { "email", "User email" },
                { "phone", "User phone" },
                { "roles", "User roles" }
            },
            options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo { Title = "Patient Service API", Version = "v1" });
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
            options.SwaggerEndpoint("/swagger/v1/swagger.json", "Patient Service API");
            options.RoutePrefix = string.Empty;

            var configuration = context.ServiceProvider.GetRequiredService<IConfiguration>();
            var selfUrl = configuration["App:SelfUrl"] ?? "https://localhost:54516";

            // **The critical line: make redirect_uri match what you register in OpenIddict**
            options.OAuth2RedirectUrl(selfUrl.TrimEnd('/') + "/swagger/oauth2-redirect.html");

            options.OAuthClientId(configuration["AuthServer:SwaggerClientId"]);
            options.OAuthScopes("digihealth", "openid", "profile", "email", "phone", "roles");
            options.OAuthUsePkce();
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

    private void ConfigureRemoteServices(IConfiguration configuration)
    {
        var baseUrl = configuration["RemoteServices:IdentityService:BaseUrl"];

        if (!string.IsNullOrWhiteSpace(baseUrl))
        {
            Configure<AbpRemoteServiceOptions>(options =>
            {
                options.RemoteServices[PatientServiceRemoteServiceConsts.IdentityService] =
                    new RemoteServiceConfiguration(baseUrl);
            });
        }
    }
}
