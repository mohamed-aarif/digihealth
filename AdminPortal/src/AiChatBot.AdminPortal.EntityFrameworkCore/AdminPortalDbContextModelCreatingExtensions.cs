using AiChatBot.AdminPortal.ChatWidgets;
using Microsoft.EntityFrameworkCore;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace AiChatBot.AdminPortal.EntityFrameworkCore;

public static class AdminPortalDbContextModelCreatingExtensions
{
    public static void ConfigureAdminPortal(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<TenantChatWidgetConfig>(b =>
        {
            b.ToTable("AdminPortalTenantChatWidgetConfigs");
            b.ConfigureByConvention();

            b.HasKey(x => x.Id);
            b.HasIndex(x => x.TenantId).IsUnique();

            b.Property(x => x.TenantId).IsRequired();
            b.Property(x => x.IsEnabled).IsRequired();
            b.Property(x => x.DefaultConfigJson).IsRequired().HasColumnType("nvarchar(max)");
            b.Property(x => x.ConfigVersion).IsRequired();

            b.HasMany(x => x.Channels)
                .WithOne(x => x.TenantConfig)
                .HasForeignKey(x => x.TenantChatWidgetConfigId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        builder.Entity<TenantChatWidgetChannelConfig>(b =>
        {
            b.ToTable("AdminPortalTenantChatWidgetChannelConfigs");
            b.ConfigureByConvention();

            b.HasKey(x => x.Id);
            b.HasIndex(x => new { x.TenantId, x.ChannelId }).IsUnique();

            b.Property(x => x.TenantId).IsRequired();
            b.Property(x => x.ChannelId)
                .IsRequired()
                .HasMaxLength(ChatWidgetConsts.MaxChannelIdLength);
            b.Property(x => x.DomainsAllowedJson).HasColumnType("nvarchar(max)");
            b.Property(x => x.ConfigJson).HasColumnType("nvarchar(max)");
        });
    }
}
