using Microsoft.EntityFrameworkCore;
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

    public PatientServiceDbContext(DbContextOptions<PatientServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        // All tables in this DbContext default to the "patient" schema
        builder.HasDefaultSchema(PatientServiceDbProperties.DbSchema); // "patient" 

        base.OnModelCreating(builder);

        builder.Entity<PatientProfileExtension>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "ProfileExtensions", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.PrimaryContactNumber).HasMaxLength(64);
            b.Property(x => x.SecondaryContactNumber).HasMaxLength(64);
            b.Property(x => x.Email).HasMaxLength(256);
            b.Property(x => x.AddressLine1).HasMaxLength(256);
            b.Property(x => x.AddressLine2).HasMaxLength(256);
            b.Property(x => x.City).HasMaxLength(128);
            b.Property(x => x.State).HasMaxLength(128);
            b.Property(x => x.ZipCode).HasMaxLength(32);
            b.Property(x => x.Country).HasMaxLength(128);
            b.Property(x => x.EmergencyContactName).HasMaxLength(128);
            b.Property(x => x.EmergencyContactNumber).HasMaxLength(64);
            b.Property(x => x.PreferredLanguage).HasMaxLength(64);
            b.HasIndex(x => x.IdentityPatientId).IsUnique();
        });

        builder.Entity<PatientMedicalSummary>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "MedicalSummaries", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.BloodGroup).HasMaxLength(32);
            b.Property(x => x.Allergies).HasMaxLength(512);
            b.Property(x => x.ChronicConditions).HasMaxLength(512);
            b.Property(x => x.Notes).HasMaxLength(2048);
            b.HasIndex(x => x.IdentityPatientId).IsUnique();
        });

        builder.Entity<PatientExternalLink>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "ExternalLinks", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.SystemName).IsRequired().HasMaxLength(128);
            b.Property(x => x.ExternalReference).IsRequired().HasMaxLength(256);
            b.HasIndex(x => new { x.IdentityPatientId, x.SystemName }).IsUnique();
        });
    }
}
