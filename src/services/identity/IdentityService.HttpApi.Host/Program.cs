using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;
using Serilog;
using Volo.Abp;
using Volo.Abp.Autofac;

namespace IdentityService;

public class Program
{
    public static int Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Host.AddAppSettingsSecretsJson();
        builder.Host.UseAutofac();
        builder.Host.UseSerilog();

        builder.Services.AddApplication<IdentityServiceHttpApiHostModule>();

        var app = builder.Build();

        app.InitializeApplication();

        app.Run();

        return 0;
    }
}
