using Microsoft.EntityFrameworkCore;
using IdentityService.Patients;
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
            b.HasKey(r => r.MigrationId);
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

            b.Property(x => x.Id).HasColumnName("id");
            b.Property(x => x.TenantId).HasColumnName("tenant_id");
            b.Property(x => x.IdentityPatientId).HasColumnName("identity_patient_id").IsRequired();
            b.Property(x => x.PrimaryContactNumber).HasColumnName("primary_contact_number").HasMaxLength(32);
            b.Property(x => x.SecondaryContactNumber).HasColumnName("secondary_contact_number").HasMaxLength(32);
            b.Property(x => x.Email).HasColumnName("email").HasMaxLength(256);
            b.Property(x => x.AddressLine1).HasColumnName("address_line1").HasMaxLength(256);
            b.Property(x => x.AddressLine2).HasColumnName("address_line2").HasMaxLength(256);
            b.Property(x => x.City).HasColumnName("city").HasMaxLength(128);
            b.Property(x => x.State).HasColumnName("state").HasMaxLength(128);
            b.Property(x => x.ZipCode).HasColumnName("zipcode").HasMaxLength(32);
            b.Property(x => x.Country).HasColumnName("country").HasMaxLength(128);
            b.Property(x => x.EmergencyContactName).HasColumnName("emergency_contact_name").HasMaxLength(256);
            b.Property(x => x.EmergencyContactNumber).HasColumnName("emergency_contact_number").HasMaxLength(32);
            b.Property(x => x.PreferredLanguage).HasColumnName("preferred_language").HasMaxLength(64);

            b.Property(x => x.CreationTime).HasColumnName("creation_time");
            b.Property(x => x.CreatorId).HasColumnName("CreatorId");
            b.Property(x => x.LastModificationTime).HasColumnName("LastModificationTime");
            b.Property(x => x.LastModifierId).HasColumnName("LastModifierId");
            b.Property(x => x.IsDeleted).HasColumnName("IsDeleted");
            b.Property(x => x.DeleterId).HasColumnName("DeleterId");
            b.Property(x => x.DeletionTime).HasColumnName("DeletionTime");
            b.Property(x => x.ExtraProperties).HasColumnName("ExtraProperties");
            b.Property(x => x.ConcurrencyStamp).HasColumnName("ConcurrencyStamp");

            b.HasIndex(x => x.IdentityPatientId).HasDatabaseName("ix_patient_profile_ext_identity_patient");
            b.HasIndex(x => x.TenantId).HasDatabaseName("ix_patient_profile_ext_tenant");

            b.HasOne<Patient>()
                .WithMany()
                .HasForeignKey(x => x.IdentityPatientId)
                .OnDelete(DeleteBehavior.NoAction)
                .HasConstraintName("fk_patient_profile_ext_patient");
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
