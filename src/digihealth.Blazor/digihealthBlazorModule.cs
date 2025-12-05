using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using digihealth.Blazor.Client;
using Volo.Abp;
using Volo.Abp.AspNetCore.Components.WebAssembly.LeptonXLiteTheme.Bundling;
using Volo.Abp.AspNetCore.Components.WebAssembly.WebApp;
using Volo.Abp.AspNetCore.Mvc.UI.Bundling;
using Volo.Abp.Autofac;
using Volo.Abp.Http.Client.IdentityModel;
using Volo.Abp.Modularity;

namespace digihealth.Blazor;

[DependsOn(
    typeof(AbpAutofacModule),
    typeof(AbpAspNetCoreMvcUiBundlingModule),
    typeof(AbpAspNetCoreComponentsWebAssemblyLeptonXLiteThemeBundlingModule)
)]
public class digihealthBlazorModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        //https://github.com/dotnet/aspnetcore/issues/52530
        Configure<RouteOptions>(options =>
        {
            options.SuppressCheckForUnhandledSecurityMetadata = true;
        });

        Configure<AbpIdentityModelOptions>(options =>
        {
            options.IdentityClients.TryAdd("AbpMvcClient", new IdentityClientConfiguration
            {
                Authority = configuration["IdentityClients:AbpMvcClient:Authority"]
                           ?? configuration["AuthServer:Authority"],
                ClientId = configuration["IdentityClients:AbpMvcClient:ClientId"]
                           ?? configuration["AuthServer:ClientId"],
                ClientSecret = configuration["IdentityClients:AbpMvcClient:ClientSecret"]
                              ?? configuration["AuthServer:ClientSecret"],
                Scope = configuration["IdentityClients:AbpMvcClient:Scope"]
                        ?? configuration["AuthServer:Scope"]
                        ?? "digihealth",
                GrantType = configuration["IdentityClients:AbpMvcClient:GrantType"]
                            ?? "client_credentials"
            });

            options.IdentityClients.Default = options.IdentityClients["AbpMvcClient"];
        });

        // Add services to the container.
        context.Services.AddRazorComponents()
            .AddInteractiveWebAssemblyComponents();
    }

    public override void OnApplicationInitialization(ApplicationInitializationContext context)
    {
        var env = context.GetEnvironment();
        var app = context.GetApplicationBuilder();

        // Configure the HTTP request pipeline.
        if (env.IsDevelopment())
        {
            app.UseWebAssemblyDebugging();
        }
        else
        {
            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        app.UseHttpsRedirection();
        app.MapAbpStaticAssets();
        app.UseRouting();
        app.UseAntiforgery();

        app.UseConfiguredEndpoints(builder =>
        {
            builder.MapRazorComponents<App>()
                .AddInteractiveWebAssemblyRenderMode()
                .AddAdditionalAssemblies(WebAppAdditionalAssembliesHelper.GetAssemblies<digihealthBlazorClientModule>());
        });
    }
}
