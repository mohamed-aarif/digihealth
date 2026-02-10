using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.MultiTenancy;
using Volo.Abp.TenantManagement;
using Volo.Abp.Uow;

namespace digihealth.EntityFrameworkCore.Data;

public class TenantSampleDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly ITenantRepository _tenantRepository;
    private readonly ICurrentTenant _currentTenant;
    private readonly IDbContextProvider<digihealthDbContext> _dbContextProvider;
    private readonly IUnitOfWorkManager _unitOfWorkManager;
    private readonly ILogger<TenantSampleDataSeedContributor> _logger;

    public TenantSampleDataSeedContributor(
        ITenantRepository tenantRepository,
        ICurrentTenant currentTenant,
        IDbContextProvider<digihealthDbContext> dbContextProvider,
        IUnitOfWorkManager unitOfWorkManager,
        ILogger<TenantSampleDataSeedContributor> logger)
    {
        _tenantRepository = tenantRepository;
        _currentTenant = currentTenant;
        _dbContextProvider = dbContextProvider;
        _unitOfWorkManager = unitOfWorkManager;
        _logger = logger;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var tenants = await _tenantRepository.GetListAsync(includeDetails: false);
        if (tenants.Count == 0)
        {
            _logger.LogInformation("No tenants found for tenant sample data seeding.");
            return;
        }

        foreach (var tenant in tenants)
        {
            using (_currentTenant.Change(tenant.Id))
            {
                await using var uow = _unitOfWorkManager.Begin(requiresNew: true, isTransactional: true);

                await SeedTenantSampleDataAsync(tenant.Id);

                await uow.CompleteAsync();
            }
        }
    }

    private async Task SeedTenantSampleDataAsync(Guid tenantId)
    {
        var dbContext = await _dbContextProvider.GetDbContextAsync();

        if (!await TableExistsAsync(dbContext, "AdminPortalAiUsageMonthly") ||
            !await TableExistsAsync(dbContext, "AdminPortalTenantSubscriptions"))
        {
            _logger.LogWarning(
                "Tenant sample data seed skipped for tenant {TenantId} because required table(s) were not found.",
                tenantId);
            return;
        }

        var utcNow = DateTime.UtcNow;

        var monthlyUsageRows = BuildMonthlyUsageSeedRows(tenantId, utcNow);
        foreach (var row in monthlyUsageRows)
        {
            await dbContext.Database.ExecuteSqlInterpolatedAsync($@"
INSERT INTO \"AdminPortalAiUsageMonthly\"
    (\"Id\", \"TenantId\", \"PeriodYear\", \"PeriodMonth\", \"RequestCount\", \"TokenCount\", \"CostUsd\", \"CreatedAt\", \"LastUpdatedAt\")
SELECT
    {row.Id}, {tenantId}, {row.PeriodYear}, {row.PeriodMonth}, {row.RequestCount}, {row.TokenCount}, {row.CostUsd}, {utcNow}, {utcNow}
WHERE NOT EXISTS (
    SELECT 1
    FROM \"AdminPortalAiUsageMonthly\"
    WHERE \"TenantId\" = {tenantId}
      AND \"PeriodYear\" = {row.PeriodYear}
      AND \"PeriodMonth\" = {row.PeriodMonth}
);");
        }

        var subscriptionRows = BuildSubscriptionSeedRows(tenantId, utcNow);
        foreach (var row in subscriptionRows)
        {
            await dbContext.Database.ExecuteSqlInterpolatedAsync($@"
INSERT INTO \"AdminPortalTenantSubscriptions\"
    (\"Id\", \"TenantId\", \"PlanCode\", \"PlanName\", \"Status\", \"StartDateUtc\", \"EndDateUtc\", \"IsAutoRenew\", \"CreatedAt\", \"LastUpdatedAt\")
SELECT
    {row.Id}, {tenantId}, {row.PlanCode}, {row.PlanName}, {row.Status}, {row.StartDateUtc}, {row.EndDateUtc}, {row.IsAutoRenew}, {utcNow}, {utcNow}
WHERE NOT EXISTS (
    SELECT 1
    FROM \"AdminPortalTenantSubscriptions\"
    WHERE \"TenantId\" = {tenantId}
      AND \"PlanCode\" = {row.PlanCode}
      AND \"StartDateUtc\" = {row.StartDateUtc}
);");
        }

        _logger.LogInformation("Seeded tenant sample data for tenant {TenantId}", tenantId);
    }

    private static List<AiUsageSeedRow> BuildMonthlyUsageSeedRows(Guid tenantId, DateTime utcNow)
    {
        var month0 = new DateTime(utcNow.Year, utcNow.Month, 1, 0, 0, 0, DateTimeKind.Utc);
        var month1 = month0.AddMonths(-1);
        var month2 = month0.AddMonths(-2);

        return
        [
            new AiUsageSeedRow(
                DeterministicGuid.Create(tenantId, $"ai-usage-{month2:yyyy-MM}"),
                month2.Year,
                month2.Month,
                1120,
                845_000,
                138.42m),
            new AiUsageSeedRow(
                DeterministicGuid.Create(tenantId, $"ai-usage-{month1:yyyy-MM}"),
                month1.Year,
                month1.Month,
                1348,
                983_000,
                162.71m),
            new AiUsageSeedRow(
                DeterministicGuid.Create(tenantId, $"ai-usage-{month0:yyyy-MM}"),
                month0.Year,
                month0.Month,
                1492,
                1_041_000,
                179.08m)
        ];
    }

    private static List<SubscriptionSeedRow> BuildSubscriptionSeedRows(Guid tenantId, DateTime utcNow)
    {
        var currentMonthStartUtc = new DateTime(utcNow.Year, utcNow.Month, 1, 0, 0, 0, DateTimeKind.Utc);

        return
        [
            new SubscriptionSeedRow(
                DeterministicGuid.Create(tenantId, "tenant-subscription-pro"),
                "PRO",
                "Professional",
                "Active",
                currentMonthStartUtc,
                currentMonthStartUtc.AddYears(1).AddDays(-1),
                true),
            new SubscriptionSeedRow(
                DeterministicGuid.Create(tenantId, "tenant-subscription-legacy-basic"),
                "BASIC",
                "Basic",
                "Expired",
                currentMonthStartUtc.AddYears(-1),
                currentMonthStartUtc.AddDays(-1),
                false)
        ];
    }

    private static async Task<bool> TableExistsAsync(digihealthDbContext dbContext, string tableName, CancellationToken cancellationToken = default)
    {
        const string sql = @"
SELECT EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_schema = current_schema()
      AND table_name = {0}
)";

        return await dbContext.Database
            .SqlQueryRaw<bool>(sql, tableName)
            .SingleAsync(cancellationToken);
    }

    private readonly record struct AiUsageSeedRow(
        Guid Id,
        int PeriodYear,
        int PeriodMonth,
        int RequestCount,
        int TokenCount,
        decimal CostUsd);

    private readonly record struct SubscriptionSeedRow(
        Guid Id,
        string PlanCode,
        string PlanName,
        string Status,
        DateTime StartDateUtc,
        DateTime EndDateUtc,
        bool IsAutoRenew);

    private static class DeterministicGuid
    {
        public static Guid Create(Guid tenantId, string seedName)
        {
            var bytes = System.Text.Encoding.UTF8.GetBytes($"{tenantId:N}:{seedName}");
            var hash = System.Security.Cryptography.SHA256.HashData(bytes);
            Span<byte> guidBytes = stackalloc byte[16];
            hash.AsSpan(0, 16).CopyTo(guidBytes);

            // RFC 4122 v4 layout
            guidBytes[6] = (byte)((guidBytes[6] & 0x0F) | 0x40);
            guidBytes[8] = (byte)((guidBytes[8] & 0x3F) | 0x80);

            return new Guid(guidBytes);
        }
    }
}
