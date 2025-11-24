using Microsoft.EntityFrameworkCore;
using PatientService.Entities;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace PatientService.EntityFrameworkCore;

public static class PatientServiceModelBuilderExtensions
{
    public static void ConfigurePatientService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<PatientProfileExtension>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "patient_profiles", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.PrimaryContactNumber).HasMaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength);
            b.Property(x => x.SecondaryContactNumber).HasMaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength);
            b.Property(x => x.Email).HasMaxLength(PatientProfileExtensionConsts.MaxEmailLength);
            b.Property(x => x.AddressLine1).HasMaxLength(PatientProfileExtensionConsts.MaxAddressLength);
            b.Property(x => x.AddressLine2).HasMaxLength(PatientProfileExtensionConsts.MaxAddressLength);
            b.Property(x => x.City).HasMaxLength(PatientProfileExtensionConsts.MaxCityLength);
            b.Property(x => x.State).HasMaxLength(PatientProfileExtensionConsts.MaxStateLength);
            b.Property(x => x.ZipCode).HasMaxLength(PatientProfileExtensionConsts.MaxZipCodeLength);
            b.Property(x => x.Country).HasMaxLength(PatientProfileExtensionConsts.MaxCountryLength);
            b.Property(x => x.EmergencyContactName).HasMaxLength(PatientProfileExtensionConsts.MaxEmergencyContactLength);
            b.Property(x => x.EmergencyContactNumber).HasMaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength);
            b.Property(x => x.PreferredLanguage).HasMaxLength(PatientProfileExtensionConsts.MaxPreferredLanguageLength);
            b.HasIndex(x => x.IdentityPatientId).IsUnique();
        });

        builder.Entity<PatientMedicalSummary>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "patient_medical_summaries", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.BloodGroup).HasMaxLength(PatientMedicalSummaryConsts.MaxBloodGroupLength);
            b.Property(x => x.Allergies).HasMaxLength(PatientMedicalSummaryConsts.MaxAllergiesLength);
            b.Property(x => x.ChronicConditions).HasMaxLength(PatientMedicalSummaryConsts.MaxChronicConditionsLength);
            b.Property(x => x.Notes).HasMaxLength(PatientMedicalSummaryConsts.MaxNotesLength);
            b.HasIndex(x => x.IdentityPatientId).IsUnique();
        });

        builder.Entity<PatientExternalLink>(b =>
        {
            b.ToTable(PatientServiceDbProperties.DbTablePrefix + "patient_external_links", PatientServiceDbProperties.DbSchema);
            b.ConfigureByConvention();
            b.Property(x => x.IdentityPatientId).IsRequired();
            b.Property(x => x.SystemName).IsRequired().HasMaxLength(PatientExternalLinkConsts.MaxSystemNameLength);
            b.Property(x => x.ExternalReference).IsRequired().HasMaxLength(PatientExternalLinkConsts.MaxExternalReferenceLength);
            b.HasIndex(x => new { x.IdentityPatientId, x.SystemName, x.ExternalReference }).IsUnique();
        });
    }
}
