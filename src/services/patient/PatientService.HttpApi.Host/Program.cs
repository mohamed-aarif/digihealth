using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Npgsql;
using PatientService.EntityFrameworkCore;
using Serilog;
using Serilog.Events;
using Volo.Abp;
using Volo.Abp.Autofac;
using Volo.Abp.Data;

namespace PatientService;

public class Program
{
    public static async Task<int> Main(string[] args)
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
            Log.Information("Starting PatientService.HttpApi.Host.");

            var builder = WebApplication.CreateBuilder(args);

            builder.Host.AddAppSettingsSecretsJson()
                .UseAutofac()
                .UseSerilog();

            builder.Services.AddApplication<PatientServiceHttpApiHostModule>();

            var app = builder.Build();

            var skipDbMigrations = builder.Configuration.GetValue("App:SkipDbMigrations", false);

            if (skipDbMigrations)
            {
                Log.Information("Database migration is skipped because App:SkipDbMigrations is true.");
            }
            else
            {
                await MigrateAndSeedDatabaseAsync(app.Services, builder.Configuration.GetConnectionString("Default") ?? string.Empty);
            }

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

    private static async Task MigrateAndSeedDatabaseAsync(IServiceProvider serviceProvider, string connectionString)
    {
        await using var scope = serviceProvider.CreateAsyncScope();
        var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();

        logger.LogInformation("Applying database migrations...");

        try
        {
            var dbContext = scope.ServiceProvider.GetRequiredService<PatientServiceDbContext>();
            await dbContext.Database.MigrateAsync();

            var dataSeeder = scope.ServiceProvider.GetRequiredService<IDataSeeder>();
            await dataSeeder.SeedAsync(new DataSeedContext(null));

            logger.LogInformation("Database ready.");
        }
        catch (PostgresException ex)
        {
            logger.LogCritical(ex, "Failed to connect to PostgreSQL using ConnectionStrings:Default = {ConnectionString}. Ensure the credentials are correct or set App:SkipDbMigrations to true.", connectionString);
            throw;
        }
    }
}
