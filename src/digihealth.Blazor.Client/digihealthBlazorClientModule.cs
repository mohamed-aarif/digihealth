using System;
using System.Net.Http;
using Blazorise.Bootstrap5;
using Blazorise.Icons.FontAwesome;
using DigiHealth.ConfigurationService;
using IdentityService;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using digihealth.Blazor.Client.Menus;
using OpenIddict.Abstractions;
using PatientService;
using Volo.Abp.AspNetCore.Components.Web.Theming.Routing;
using Volo.Abp.AspNetCore.Components.WebAssembly.LeptonXLiteTheme;
using Volo.Abp.Autofac.WebAssembly;
using Volo.Abp.AutoMapper;
using Volo.Abp.Identity.Blazor.WebAssembly;
using Volo.Abp.Modularity;
using Volo.Abp.Http.Client;
using Volo.Abp.PermissionManagement.Blazor.WebAssembly;
using Volo.Abp.SettingManagement.Blazor.WebAssembly;
using Volo.Abp.TenantManagement.Blazor.WebAssembly;
using Volo.Abp.UI.Navigation;

namespace digihealth.Blazor.Client;

[DependsOn(
    typeof(AbpAutofacWebAssemblyModule),
    typeof(digihealthHttpApiClientModule),
    typeof(ConfigurationServiceHttpApiClientModule),
    typeof(AbpAspNetCoreComponentsWebAssemblyLeptonXLiteThemeModule),
    typeof(AbpIdentityBlazorWebAssemblyModule),
    typeof(AbpPermissionManagementBlazorWebAssemblyModule),
    typeof(AbpTenantManagementBlazorWebAssemblyModule),
    typeof(AbpSettingManagementBlazorWebAssemblyModule)
)]
public class digihealthBlazorClientModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var environment = context.Services.GetSingletonInstance<IWebAssemblyHostEnvironment>();
        var builder = context.Services.GetSingletonInstance<WebAssemblyHostBuilder>();

        ConfigureAuthentication(builder);
        ConfigureHttpClient(context, environment);
        ConfigureBlazorise(context);
        ConfigureRouter(context);
        ConfigureMenu(context);
        ConfigureAutoMapper(context);
        ConfigureRemoteServices(context);
    }

    private void ConfigureRouter(ServiceConfigurationContext context)
    {
        Configure<AbpRouterOptions>(options =>
        {
            options.AppAssembly = typeof(digihealthBlazorClientModule).Assembly;
        });
    }

    private void ConfigureMenu(ServiceConfigurationContext context)
    {
        Configure<AbpNavigationOptions>(options =>
        {
            options.MenuContributors.Add(new digihealthMenuContributor(context.Services.GetConfiguration()));
        });
    }

    private void ConfigureBlazorise(ServiceConfigurationContext context)
    {
        context.Services
            .AddBootstrap5Providers()
            .AddFontAwesomeIcons();
    }

    private static void ConfigureAuthentication(WebAssemblyHostBuilder builder)
    {
        builder.Services.AddOidcAuthentication(options =>
        {
            builder.Configuration.Bind("AuthServer", options.ProviderOptions);
            options.UserOptions.NameClaim = OpenIddictConstants.Claims.Name;
            options.UserOptions.RoleClaim = OpenIddictConstants.Claims.Role;

            options.ProviderOptions.DefaultScopes.Add("digihealth");
            options.ProviderOptions.DefaultScopes.Add("roles");
            options.ProviderOptions.DefaultScopes.Add("email");
            options.ProviderOptions.DefaultScopes.Add("phone");
        });
    }

    private static void ConfigureHttpClient(ServiceConfigurationContext context, IWebAssemblyHostEnvironment environment)
    {
        context.Services.AddTransient(sp => new HttpClient
        {
            BaseAddress = new Uri(environment.BaseAddress)
        });
    }

    private void ConfigureAutoMapper(ServiceConfigurationContext context)
    {
        Configure<AbpAutoMapperOptions>(options =>
        {
            options.AddMaps<digihealthBlazorClientModule>();
        });
    }

    private void ConfigureRemoteServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        Configure<AbpRemoteServiceOptions>(options =>
        {
            var defaultBaseUrl = configuration["RemoteServices:Default:BaseUrl"];
            if (!string.IsNullOrWhiteSpace(defaultBaseUrl))
            {
                options.RemoteServices.Default = new RemoteServiceConfiguration(defaultBaseUrl);
            }

            ConfigureRemoteService(options, configuration, ConfigurationServiceRemoteServiceConsts.RemoteServiceName);
            ConfigureRemoteService(options, configuration, "IdentityService");
            ConfigureRemoteService(options, configuration, "PatientService");
        });

        context.Services.AddHttpClientProxies(
            typeof(ConfigurationServiceApplicationContractsModule).Assembly,
            ConfigurationServiceRemoteServiceConsts.RemoteServiceName
        );

        context.Services.AddHttpClientProxies(
            typeof(IdentityServiceApplicationContractsModule).Assembly,
            "IdentityService"
        );

        context.Services.AddHttpClientProxies(
            typeof(PatientServiceApplicationContractsModule).Assembly,
            "PatientService"
        );
    }

    private static void ConfigureRemoteService(AbpRemoteServiceOptions options, IConfiguration configuration, string serviceName)
    {
        var baseUrl = configuration[$"RemoteServices:{serviceName}:BaseUrl"];

        if (!string.IsNullOrWhiteSpace(baseUrl))
        {
            options.RemoteServices[serviceName] = new RemoteServiceConfiguration(baseUrl);
        }
    }
}
