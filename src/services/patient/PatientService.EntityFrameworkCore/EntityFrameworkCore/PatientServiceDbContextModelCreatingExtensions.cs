using PatientService.ExternalLinks;
using PatientService.MedicalSummaries;
using PatientService.PatientProfiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

public static class PatientServiceDbContextModelCreatingExtensions
{
    public static void ConfigurePatientService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<PatientProfileExtension>(ConfigurePatientProfile);
        builder.Entity<PatientMedicalSummary>(ConfigureMedicalSummary);
        builder.Entity<PatientExternalLink>(ConfigureExternalLink);
    }

    private static void ConfigurePatientProfile(EntityTypeBuilder<PatientProfileExtension> b)
    {
        b.ToTable("patient_profile_extensions", PatientServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.IdentityPatientId)
            .HasColumnName("identity_patient_id")
            .IsRequired();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

        b.Property(x => x.PrimaryContactNumber)
            .HasColumnName("primary_contact_number")
            .HasMaxLength(PatientProfileExtensionConsts.MaxPrimaryContactLength);

        b.Property(x => x.SecondaryContactNumber)
            .HasColumnName("secondary_contact_number")
            .HasMaxLength(PatientProfileExtensionConsts.MaxSecondaryContactLength);

        b.Property(x => x.Email)
            .HasColumnName("email")
            .HasMaxLength(PatientProfileExtensionConsts.MaxEmailLength);

        b.Property(x => x.AddressLine1)
            .HasColumnName("address_line1")
            .HasMaxLength(PatientProfileExtensionConsts.MaxAddressLineLength);

        b.Property(x => x.AddressLine2)
            .HasColumnName("address_line2")
            .HasMaxLength(PatientProfileExtensionConsts.MaxAddressLineLength);

        b.Property(x => x.City)
            .HasColumnName("city")
            .HasMaxLength(PatientProfileExtensionConsts.MaxCityLength);

        b.Property(x => x.State)
            .HasColumnName("state")
            .HasMaxLength(PatientProfileExtensionConsts.MaxStateLength);

        b.Property(x => x.ZipCode)
            .HasColumnName("zip_code")
            .HasMaxLength(PatientProfileExtensionConsts.MaxZipCodeLength);

        b.Property(x => x.Country)
            .HasColumnName("country")
            .HasMaxLength(PatientProfileExtensionConsts.MaxCountryLength);

        b.Property(x => x.EmergencyContactName)
            .HasColumnName("emergency_contact_name")
            .HasMaxLength(PatientProfileExtensionConsts.MaxEmergencyContactNameLength);

        b.Property(x => x.EmergencyContactNumber)
            .HasColumnName("emergency_contact_number")
            .HasMaxLength(PatientProfileExtensionConsts.MaxEmergencyContactNumberLength);

        b.Property(x => x.PreferredLanguage)
            .HasColumnName("preferred_language")
            .HasMaxLength(PatientProfileExtensionConsts.MaxPreferredLanguageLength);

        b.HasIndex(x => x.IdentityPatientId).IsUnique();
        b.HasIndex(x => x.TenantId);
    }

    private static void ConfigureMedicalSummary(EntityTypeBuilder<PatientMedicalSummary> b)
    {
        b.ToTable("patient_medical_summaries", PatientServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.IdentityPatientId)
            .HasColumnName("identity_patient_id")
            .IsRequired();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

        b.Property(x => x.BloodGroup)
            .HasColumnName("blood_group")
            .HasMaxLength(PatientMedicalSummaryConsts.MaxBloodGroupLength);

        b.Property(x => x.Allergies)
            .HasColumnName("allergies")
            .HasMaxLength(PatientMedicalSummaryConsts.MaxAllergiesLength);

        b.Property(x => x.ChronicConditions)
            .HasColumnName("chronic_conditions")
            .HasMaxLength(PatientMedicalSummaryConsts.MaxChronicConditionsLength);

        b.Property(x => x.Notes)
            .HasColumnName("notes")
            .HasMaxLength(PatientMedicalSummaryConsts.MaxNotesLength);

        b.HasIndex(x => x.IdentityPatientId).IsUnique();
        b.HasIndex(x => x.TenantId);
    }

    private static void ConfigureExternalLink(EntityTypeBuilder<PatientExternalLink> b)
    {
        b.ToTable("patient_external_links", PatientServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.IdentityPatientId)
            .HasColumnName("identity_patient_id")
            .IsRequired();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

        b.Property(x => x.SystemName)
            .HasColumnName("system_name")
            .IsRequired()
            .HasMaxLength(PatientExternalLinkConsts.MaxSystemNameLength);

        b.Property(x => x.ExternalReference)
            .HasColumnName("external_reference")
            .IsRequired()
            .HasMaxLength(PatientExternalLinkConsts.MaxExternalReferenceLength);

        b.HasIndex(x => new { x.IdentityPatientId, x.SystemName }).IsUnique();
        b.HasIndex(x => x.TenantId);
    }
}
