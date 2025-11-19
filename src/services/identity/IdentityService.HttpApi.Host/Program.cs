using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityService.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;
using Serilog.Events;
using Volo.Abp;
using Volo.Abp.Autofac;
using Volo.Abp.Data;

namespace IdentityService;

public class Program
{
    public async static Task<int> Main(string[] args)
    {
        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
        AppContext.SetSwitch("Npgsql.DisableDateTimeInfinityConversions", true);

        Log.Logger = new LoggerConfiguration()
#if DEBUG
            .MinimumLevel.Debug()
#else
            .MinimumLevel.Information()
#endif
            .MinimumLevel.Override("Microsoft", LogEventLevel.Information)
            .MinimumLevel.Override("Microsoft.EntityFrameworkCore", LogEventLevel.Warning)
            .Enrich.FromLogContext()
            .WriteTo.File("Logs/logs.txt")
            .WriteTo.Console()
            .CreateLogger();

        try
        {
            Log.Information("Starting IdentityService.HttpApi.Host.");

            var builder = WebApplication.CreateBuilder(args);

            builder.Host.AddAppSettingsSecretsJson()
                .UseAutofac()
                .UseSerilog();

            builder.Services.AddApplication<IdentityServiceHttpApiHostModule>();

            var app = builder.Build();

            await MigrateAndSeedDatabaseAsync(app.Services);

            await app.InitializeApplicationAsync();
            await app.RunAsync();

            return 0;
        }
        catch (Exception ex)
        {
            if (ex is HostAbortedException)
            {
                throw;
            }

            Log.Fatal(ex, "Host terminated unexpectedly!");
            return 1;
        }
        finally
        {
            Log.CloseAndFlush();
        }
    }

    private static async Task MigrateAndSeedDatabaseAsync(IServiceProvider serviceProvider)
    {
        await using var scope = serviceProvider.CreateAsyncScope();

        var migrators = scope.ServiceProvider.GetRequiredService<IEnumerable<IIdentityServiceDbSchemaMigrator>>();
        foreach (var migrator in migrators)
        {
            await migrator.MigrateAsync();
        }

        var dataSeeder = scope.ServiceProvider.GetRequiredService<IDataSeeder>();
        await dataSeeder.SeedAsync(new DataSeedContext(null));
    }
}
