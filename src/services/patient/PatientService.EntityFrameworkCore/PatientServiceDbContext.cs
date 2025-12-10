using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using PatientService.Meals;
using PatientService.PatientExternalLinks;
using PatientService.PatientMedicalSummaries;
using PatientService.PatientProfiles;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

[ConnectionStringName(PatientServiceDbProperties.ConnectionStringName)]
public class PatientServiceDbContext : AbpDbContext<PatientServiceDbContext>
{
    public DbSet<PatientProfileExtension> PatientProfiles { get; set; } = null!;
    public DbSet<PatientMedicalSummary> PatientMedicalSummaries { get; set; } = null!;
    public DbSet<PatientExternalLink> PatientExternalLinks { get; set; } = null!;
    public DbSet<Meal> Meals { get; set; } = null!;
    public DbSet<MealItem> MealItems { get; set; } = null!;

    public PatientServiceDbContext(DbContextOptions<PatientServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.HasDefaultSchema(PatientServiceDbProperties.DbSchema);

        base.OnModelCreating(builder);

        ConfigurePatientService(builder);

        builder.Entity<HistoryRow>(b =>
        {
            b.ToTable(HistoryRepository.DefaultTableName, PatientServiceDbProperties.DbSchema);
            b.Property(r => r.MigrationId).HasColumnName("MigrationId");
            b.Property(r => r.ProductVersion).HasColumnName("ProductVersion");
        });
    }

    private static void ConfigurePatientService(ModelBuilder builder)
    {
        builder.Entity<PatientProfileExtension>(b =>
        {
            b.ToTable("patient_profile_extensions", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.PrimaryContactNumber).HasMaxLength(32);
            b.Property(x => x.SecondaryContactNumber).HasMaxLength(32);
            b.Property(x => x.Email).HasMaxLength(256);
            b.Property(x => x.AddressLine1).HasMaxLength(256);
            b.Property(x => x.AddressLine2).HasMaxLength(256);
            b.Property(x => x.City).HasMaxLength(128);
            b.Property(x => x.State).HasMaxLength(128);
            b.Property(x => x.ZipCode).HasMaxLength(32);
            b.Property(x => x.Country).HasMaxLength(128);
            b.Property(x => x.EmergencyContactName).HasMaxLength(256);
            b.Property(x => x.EmergencyContactNumber).HasMaxLength(32);
            b.Property(x => x.PreferredLanguage).HasMaxLength(64);
            b.HasIndex(x => x.IdentityPatientId).HasDatabaseName("ix_patient_profile_ext_identity_patient");
            b.HasIndex(x => x.TenantId).HasDatabaseName("ix_patient_profile_ext_tenant");
        });

        builder.Entity<PatientMedicalSummary>(b =>
        {
            b.ToTable("patient_medical_summaries", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.BloodGroup).HasMaxLength(8);
            b.Property(x => x.Allergies).HasColumnType("text");
            b.Property(x => x.ChronicConditions).HasColumnType("text");
            b.Property(x => x.Notes).HasColumnType("text");
            b.HasIndex(x => x.IdentityPatientId).HasDatabaseName("ix_patient_med_summaries_identity_patient");
            b.HasIndex(x => x.TenantId).HasDatabaseName("ix_patient_med_summaries_tenant");
        });

        builder.Entity<PatientExternalLink>(b =>
        {
            b.ToTable("patient_external_links", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.SystemName).IsRequired().HasMaxLength(128);
            b.Property(x => x.ExternalReference).IsRequired().HasMaxLength(256);
            b.HasIndex(x => x.IdentityPatientId).HasDatabaseName("ix_patient_ext_links_identity_patient");
            b.HasIndex(x => x.TenantId).HasDatabaseName("ix_patient_ext_links_tenant");
            b.HasIndex(x => x.SystemName).HasDatabaseName("ix_patient_ext_links_system");
        });

        builder.Entity<Meal>(b =>
        {
            b.ToTable("meals", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.MealTime).IsRequired();
            b.Property(x => x.MealType).IsRequired().HasMaxLength(32);
            b.Property(x => x.TotalCalories).HasColumnType("numeric(8,2)");
            b.Property(x => x.MetadataJson).HasColumnType("text");
            b.HasIndex(x => new { x.IdentityPatientId, x.MealTime }).HasDatabaseName("ix_meals_patient_time");
            b.Navigation(x => x.MealItems).AutoInclude();
        });

        builder.Entity<MealItem>(b =>
        {
            b.ToTable("meal_items", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.MealId).IsRequired();
            b.Property(x => x.FoodName).IsRequired().HasMaxLength(256);
            b.Property(x => x.PortionSize).HasMaxLength(64);
            b.Property(x => x.Calories).HasColumnType("numeric(8,2)");
            b.Property(x => x.ProteinGrams).HasColumnType("numeric(8,2)");
            b.Property(x => x.CarbsGrams).HasColumnType("numeric(8,2)");
            b.Property(x => x.FatsGrams).HasColumnType("numeric(8,2)");
            b.Property(x => x.MetadataJson).HasColumnType("text");
            b.HasIndex(x => x.MealId).HasDatabaseName("ix_meal_items_meal");
            b.HasOne<Meal>().WithMany(m => m.MealItems).HasForeignKey(x => x.MealId).IsRequired();
        });
    }
}
