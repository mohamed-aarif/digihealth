using Microsoft.EntityFrameworkCore;
using PatientService.Patients;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

public static class PatientServiceDbContextModelCreatingExtensions
{
    public static void ConfigurePatientService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<PatientProfileExtension>(b =>
        {
            b.ToTable("patient_profile_extensions", PatientServiceDbProperties.DbSchema);
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

            b.HasIndex(x => new { x.IdentityPatientId, x.TenantId }).IsUnique();
        });

        builder.Entity<PatientMedicalSummary>(b =>
        {
            b.ToTable("patient_medical_summaries", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();

            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.BloodGroup).HasMaxLength(32);
            b.Property(x => x.Allergies).HasMaxLength(512);
            b.Property(x => x.ChronicConditions).HasMaxLength(512);
            b.Property(x => x.Notes).HasMaxLength(2048);

            b.HasIndex(x => new { x.IdentityPatientId, x.TenantId }).IsUnique();
        });

        builder.Entity<PatientExternalLink>(b =>
        {
            b.ToTable("patient_external_links", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();

            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.SystemName).IsRequired().HasMaxLength(128);
            b.Property(x => x.ExternalReference).IsRequired().HasMaxLength(256);

            b.HasIndex(x => new { x.IdentityPatientId, x.SystemName, x.TenantId }).IsUnique();
        });
    }
}
