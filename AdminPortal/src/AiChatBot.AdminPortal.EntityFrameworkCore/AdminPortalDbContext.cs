using AiChatBot.AdminPortal.ChatWidgets;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;

namespace AiChatBot.AdminPortal.EntityFrameworkCore;

[ConnectionStringName("Default")]
public class AdminPortalDbContext : AbpDbContext<AdminPortalDbContext>
{
    public DbSet<TenantChatWidgetConfig> TenantChatWidgetConfigs { get; set; }

    public DbSet<TenantChatWidgetChannelConfig> TenantChatWidgetChannelConfigs { get; set; }

    public AdminPortalDbContext(DbContextOptions<AdminPortalDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.ConfigureAdminPortal();
    }
}
