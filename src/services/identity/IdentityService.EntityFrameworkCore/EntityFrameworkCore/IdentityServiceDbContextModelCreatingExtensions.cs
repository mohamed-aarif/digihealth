using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.PatientIdentifiers;
using IdentityService.PatientInsurances;
using IdentityService.Patients;
using IdentityService.Users;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;

namespace IdentityService.EntityFrameworkCore;

public static class IdentityServiceDbContextModelCreatingExtensions
{
    public static void ConfigureIdentityService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<IdentityUserAccount>(ConfigureIdentityUserAccount);
        builder.Entity<Patient>(ConfigurePatient);
        builder.Entity<Doctor>(ConfigureDoctor);
        builder.Entity<FamilyLink>(ConfigureFamilyLink);
        builder.Entity<PatientIdentifier>(ConfigurePatientIdentifier);
        builder.Entity<PatientInsurance>(ConfigurePatientInsurance);
    }

    private static void ConfigureIdentityUserAccount(EntityTypeBuilder<IdentityUserAccount> b)
    {
        b.ToTable("users", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.UserName)
            .HasColumnName("user_name")
            .IsRequired()
            .HasMaxLength(IdentityUserAccountConsts.MaxUserNameLength);

        b.Property(x => x.Email)
            .HasColumnName("email")
            .IsRequired()
            .HasMaxLength(IdentityUserAccountConsts.MaxEmailLength);

        b.Property(x => x.PasswordHash)
            .HasColumnName("password_hash")
            .IsRequired()
            .HasMaxLength(IdentityUserAccountConsts.MaxPasswordHashLength);

        b.Property(x => x.UserType)
            .HasColumnName("user_type")
            .IsRequired()
            .HasMaxLength(IdentityUserAccountConsts.MaxUserTypeLength);

        b.Property(x => x.IsActive)
            .HasColumnName("is_active")
            .IsRequired();

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.Property(x => x.PhotoStorageKey)
            .HasColumnName("photo_storage_key")
            .HasMaxLength(IdentityUserAccountConsts.MaxPhotoStorageKeyLength);

        b.HasIndex(x => x.UserName).IsUnique();
        b.HasIndex(x => x.Email).IsUnique();
    }

    private static void ConfigurePatient(EntityTypeBuilder<Patient> b)
    {
        b.ToTable("patients", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.UserId)
            .HasColumnName("user_id")
            .IsRequired();

        b.Property(x => x.FullName)
            .HasColumnName("full_name")
            .IsRequired()
            .HasMaxLength(PatientConsts.MaxFullNameLength);

        b.Property(x => x.DateOfBirth)
            .HasColumnName("date_of_birth");

        b.Property(x => x.Gender)
            .HasColumnName("gender")
            .HasMaxLength(PatientConsts.MaxGenderLength);

        b.Property(x => x.Salutation)
            .HasColumnName("salutation")
            .HasMaxLength(PatientConsts.MaxSalutationLength);

        b.Property(x => x.Country)
            .HasColumnName("country")
            .HasMaxLength(PatientConsts.MaxCountryLength);

        b.Property(x => x.ResidenceCountry)
            .HasColumnName("residence_country")
            .HasMaxLength(PatientConsts.MaxResidenceCountryLength);

        b.Property(x => x.MobileNumber)
            .HasColumnName("mobile_number")
            .HasMaxLength(PatientConsts.MaxMobileNumberLength);

        b.Property(x => x.HealthVaultId)
            .HasColumnName("healthvault_id")
            .HasMaxLength(PatientConsts.MaxHealthVaultIdLength);

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.HasIndex(x => x.HealthVaultId).IsUnique();

        b.HasOne<IdentityUserAccount>()
            .WithMany()
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigureDoctor(EntityTypeBuilder<Doctor> b)
    {
        b.ToTable("doctors", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.UserId)
            .HasColumnName("user_id")
            .IsRequired();

        b.Property(x => x.FullName)
            .HasColumnName("full_name")
            .IsRequired()
            .HasMaxLength(DoctorConsts.MaxFullNameLength);

        b.Property(x => x.Salutation)
            .HasColumnName("salutation")
            .HasMaxLength(DoctorConsts.MaxSalutationLength);

        b.Property(x => x.Gender)
            .HasColumnName("gender")
            .HasMaxLength(DoctorConsts.MaxGenderLength);

        b.Property(x => x.Specialty)
            .HasColumnName("specialty")
            .HasMaxLength(DoctorConsts.MaxSpecialtyLength);

        b.Property(x => x.RegistrationNumber)
            .HasColumnName("registration_no")
            .HasMaxLength(DoctorConsts.MaxRegistrationNumberLength);

        b.Property(x => x.ClinicName)
            .HasColumnName("clinic_name")
            .HasMaxLength(DoctorConsts.MaxClinicNameLength);

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.HasOne<IdentityUserAccount>()
            .WithMany()
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigureFamilyLink(EntityTypeBuilder<FamilyLink> b)
    {
        b.ToTable("family_links", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.PatientId)
            .HasColumnName("patient_id")
            .IsRequired();

        b.Property(x => x.FamilyUserId)
            .HasColumnName("family_user_id")
            .IsRequired();

        b.Property(x => x.Relationship)
            .HasColumnName("relationship")
            .IsRequired()
            .HasMaxLength(FamilyLinkConsts.MaxRelationshipLength);

        b.Property(x => x.IsGuardian)
            .HasColumnName("is_guardian")
            .IsRequired();

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.HasIndex(x => new { x.PatientId, x.FamilyUserId }).IsUnique();

        b.HasOne<Patient>()
            .WithMany()
            .HasForeignKey(x => x.PatientId)
            .OnDelete(DeleteBehavior.Cascade);

        b.HasOne<IdentityUserAccount>()
            .WithMany()
            .HasForeignKey(x => x.FamilyUserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigurePatientIdentifier(EntityTypeBuilder<PatientIdentifier> b)
    {
        b.ToTable("patient_identifiers", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.PatientId)
            .HasColumnName("patient_id")
            .IsRequired();

        b.Property(x => x.IdType)
            .HasColumnName("id_type")
            .IsRequired()
            .HasMaxLength(PatientIdentifierConsts.MaxIdTypeLength);

        b.Property(x => x.IdNumber)
            .HasColumnName("id_number")
            .IsRequired()
            .HasMaxLength(PatientIdentifierConsts.MaxIdNumberLength);

        b.Property(x => x.IssuerCountry)
            .HasColumnName("issuer_country")
            .HasMaxLength(PatientIdentifierConsts.MaxIssuerCountryLength);

        b.Property(x => x.IssueDate)
            .HasColumnName("issue_date");

        b.Property(x => x.ExpiryDate)
            .HasColumnName("expiry_date");

        b.Property(x => x.Notes)
            .HasColumnName("notes")
            .HasMaxLength(PatientIdentifierConsts.MaxNotesLength);

        b.Property(x => x.RecordId)
            .HasColumnName("record_id");

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.HasIndex(x => new { x.PatientId, x.IdType, x.IdNumber }).IsUnique();

        b.HasOne<Patient>()
            .WithMany()
            .HasForeignKey(x => x.PatientId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigurePatientInsurance(EntityTypeBuilder<PatientInsurance> b)
    {
        b.ToTable("patient_insurances", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();
        b.Ignore(x => x.ConcurrencyStamp);
        b.Ignore(x => x.ExtraProperties);

        b.Property(x => x.Id)
            .HasColumnName("id")
            .ValueGeneratedOnAdd();

        b.Property(x => x.PatientId)
            .HasColumnName("patient_id")
            .IsRequired();

        b.Property(x => x.InsurerName)
            .HasColumnName("insurer_name")
            .IsRequired()
            .HasMaxLength(PatientInsuranceConsts.MaxInsurerNameLength);

        b.Property(x => x.PolicyNumber)
            .HasColumnName("policy_number")
            .HasMaxLength(PatientInsuranceConsts.MaxPolicyNumberLength);

        b.Property(x => x.MemberId)
            .HasColumnName("member_id")
            .HasMaxLength(PatientInsuranceConsts.MaxMemberIdLength);

        b.Property(x => x.PlanName)
            .HasColumnName("plan_name")
            .HasMaxLength(PatientInsuranceConsts.MaxPlanNameLength);

        b.Property(x => x.InsurerCountry)
            .HasColumnName("insurer_country")
            .HasMaxLength(PatientInsuranceConsts.MaxInsurerCountryLength);

        b.Property(x => x.IssueDate)
            .HasColumnName("issue_date");

        b.Property(x => x.ExpiryDate)
            .HasColumnName("expiry_date");

        b.Property(x => x.IsActive)
            .HasColumnName("is_active")
            .IsRequired();

        b.Property(x => x.RecordId)
            .HasColumnName("record_id");

        b.Property(x => x.CreatedAt)
            .HasColumnName("created_at")
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        b.HasIndex(x => new { x.PatientId, x.InsurerName, x.PolicyNumber });

        b.HasOne<Patient>()
            .WithMany()
            .HasForeignKey(x => x.PatientId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
