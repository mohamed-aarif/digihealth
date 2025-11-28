using DigiHealth.ConfigurationService.ConfigurationLookups;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;

namespace DigiHealth.ConfigurationService.EntityFrameworkCore;

[ConnectionStringName("ConfigurationService")]
public class ConfigurationServiceDbContext : AbpDbContext<ConfigurationServiceDbContext>
{
    public DbSet<AppointmentStatus> AppointmentStatuses { get; set; }
    public DbSet<AppointmentChannel> AppointmentChannels { get; set; }
    public DbSet<ConsentPartyType> ConsentPartyTypes { get; set; }
    public DbSet<ConsentStatus> ConsentStatuses { get; set; }
    public DbSet<DayOfWeekConfig> DaysOfWeekConfigs { get; set; }
    public DbSet<DeviceTypeConfig> DeviceTypes { get; set; }
    public DbSet<MedicationIntakeStatus> MedicationIntakeStatuses { get; set; }
    public DbSet<NotificationChannelConfig> NotificationChannels { get; set; }
    public DbSet<NotificationStatusConfig> NotificationStatuses { get; set; }
    public DbSet<VaultRecordTypeConfig> VaultRecordTypes { get; set; }

    public ConfigurationServiceDbContext(DbContextOptions<ConfigurationServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<AppointmentStatus>(b =>
        {
            b.ToTable("appointment_statuses", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<AppointmentChannel>(b =>
        {
            b.ToTable("appointment_channels", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<ConsentPartyType>(b =>
        {
            b.ToTable("consent_party_types", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<ConsentStatus>(b =>
        {
            b.ToTable("consent_statuses", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<DayOfWeekConfig>(b =>
        {
            b.ToTable("days_of_week", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(32);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(64);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<DeviceTypeConfig>(b =>
        {
            b.ToTable("device_types", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<MedicationIntakeStatus>(b =>
        {
            b.ToTable("medication_intake_statuses", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<NotificationChannelConfig>(b =>
        {
            b.ToTable("notification_channels", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<NotificationStatusConfig>(b =>
        {
            b.ToTable("notification_statuses", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });

        builder.Entity<VaultRecordTypeConfig>(b =>
        {
            b.ToTable("vault_record_types", schema: "configuration");
            b.HasKey(x => x.Id);
            b.Property(x => x.Code).IsRequired().HasMaxLength(64);
            b.HasIndex(x => x.Code).IsUnique();
            b.Property(x => x.Name).IsRequired().HasMaxLength(128);
            b.Property(x => x.Description);
            b.Property(x => x.SortOrder).IsRequired().HasDefaultValue(0);
            b.Property(x => x.IsActive).IsRequired().HasDefaultValue(true);
        });
    }
}
