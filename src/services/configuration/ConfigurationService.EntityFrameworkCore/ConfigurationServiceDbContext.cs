using System;
using DigiHealth.ConfigurationService.ConfigurationLookups;
using DigiHealth.ConfigurationService;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;

namespace DigiHealth.ConfigurationService.EntityFrameworkCore;

[ConnectionStringName(ConfigurationServiceDbProperties.ConnectionStringName)]
public class ConfigurationServiceDbContext : AbpDbContext<ConfigurationServiceDbContext>
{
    public DbSet<AppointmentStatus> AppointmentStatuses { get; set; } = null!;
    public DbSet<AppointmentChannel> AppointmentChannels { get; set; } = null!;
    public DbSet<ConsentPartyType> ConsentPartyTypes { get; set; } = null!;
    public DbSet<ConsentStatus> ConsentStatuses { get; set; } = null!;
    public DbSet<DayOfWeekConfig> DaysOfWeekConfigs { get; set; } = null!;
    public DbSet<DeviceReadingType> DeviceReadingTypes { get; set; } = null!;
    public DbSet<DeviceType> DeviceTypes { get; set; } = null!;
    public DbSet<MedicationIntakeStatus> MedicationIntakeStatuses { get; set; } = null!;
    public DbSet<NotificationChannel> NotificationChannels { get; set; } = null!;
    public DbSet<NotificationStatus> NotificationStatuses { get; set; } = null!;
    public DbSet<RelationshipType> RelationshipTypes { get; set; } = null!;
    public DbSet<VaultRecordType> VaultRecordTypes { get; set; } = null!;

    public ConfigurationServiceDbContext(DbContextOptions<ConfigurationServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.HasDefaultSchema(ConfigurationServiceDbProperties.DbSchema);

        base.OnModelCreating(builder);

        ConfigureLookupEntity(builder.Entity<AppointmentStatus>(), "appointment_statuses");
        ConfigureLookupEntity(builder.Entity<AppointmentChannel>(), "appointment_channels");
        ConfigureLookupEntity(builder.Entity<ConsentPartyType>(), "consent_party_types");
        ConfigureLookupEntity(builder.Entity<ConsentStatus>(), "consent_statuses");
        ConfigureLookupEntity(builder.Entity<DeviceReadingType>(), "device_reading_types", b =>
        {
            b.Property(x => x.Unit).HasMaxLength(ConfigurationLookupConsts.UnitMaxLength).HasColumnName("unit");
        });
        ConfigureLookupEntity(builder.Entity<DeviceType>(), "device_types");
        ConfigureLookupEntity(builder.Entity<MedicationIntakeStatus>(), "medication_intake_statuses");
        ConfigureLookupEntity(builder.Entity<NotificationChannel>(), "notification_channels");
        ConfigureLookupEntity(builder.Entity<NotificationStatus>(), "notification_statuses");
        ConfigureLookupEntity(builder.Entity<RelationshipType>(), "relationship_types");
        ConfigureLookupEntity(builder.Entity<VaultRecordType>(), "vault_record_types");

        builder.Entity<DayOfWeekConfig>(b =>
        {
            b.ToTable("days_of_week", schema: ConfigurationServiceDbProperties.DbSchema);
            b.HasKey(x => x.Id);
            b.Property(x => x.Id).HasColumnName("id");
            b.Property(x => x.Code).IsRequired().HasMaxLength(ConfigurationLookupConsts.DayOfWeekCodeMaxLength)
                .HasColumnName("code");
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(ConfigurationLookupConsts.DayOfWeekNameMaxLength)
                .HasColumnName("name");
            b.Property(x => x.Description).HasColumnName("description");
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0).HasColumnName("sort_order");
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true).HasColumnName("is_active");
        });
    }

    private static void ConfigureLookupEntity<TEntity>(EntityTypeBuilder<TEntity> b, string tableName,
        Action<EntityTypeBuilder<TEntity>>? configureAdditionalProperties = null)
        where TEntity : ConfigurationLookupBase
    {
        b.ToTable(tableName, schema: ConfigurationServiceDbProperties.DbSchema);
        b.HasKey(x => x.Id);
        b.Property(x => x.Id).HasColumnName("id");
        b.Property(x => x.Code).IsRequired().HasMaxLength(ConfigurationLookupConsts.MaxCodeLength).HasColumnName("code");
        b.HasIndex(x => x.Code).IsUnique();
        b.Property(x => x.Name).IsRequired().HasMaxLength(ConfigurationLookupConsts.MaxNameLength).HasColumnName("name");
        b.Property(x => x.Description).HasColumnName("description");
        b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0).HasColumnName("sort_order");
        b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true).HasColumnName("is_active");

        configureAdditionalProperties?.Invoke(b);
    }
}
