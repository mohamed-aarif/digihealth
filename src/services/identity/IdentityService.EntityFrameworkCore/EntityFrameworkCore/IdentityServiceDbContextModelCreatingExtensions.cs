using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Volo.Abp;
using Volo.Abp.EntityFrameworkCore.Modeling;
using Volo.Abp.Identity;

namespace IdentityService.EntityFrameworkCore;

public static class IdentityServiceDbContextModelCreatingExtensions
{
    public static void ConfigureIdentityService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<Patient>(ConfigurePatient);
        builder.Entity<Doctor>(ConfigureDoctor);
        builder.Entity<FamilyLink>(ConfigureFamilyLink);
    }

    private static void ConfigurePatient(EntityTypeBuilder<Patient> b)
    {
        b.ToTable("patients", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.UserId)
            .HasColumnName("user_id")
            .IsRequired();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

        b.Property(x => x.Salutation)
            .HasColumnName("salutation")
            .HasMaxLength(PatientConsts.MaxSalutationLength);

        b.Property(x => x.DateOfBirth)
            .HasColumnName("date_of_birth");

        b.Property(x => x.Gender)
            .HasColumnName("gender")
            .HasMaxLength(PatientConsts.MaxGenderLength);

        b.Property(x => x.ResidenceCountry)
            .HasColumnName("residence_country")
            .HasMaxLength(PatientConsts.MaxResidenceCountryLength);

        b.Property(x => x.CreationTime)
            .HasColumnName("creation_time")
            .IsRequired();

        b.HasIndex(x => x.UserId).IsUnique();
    }

    private static void ConfigureDoctor(EntityTypeBuilder<Doctor> b)
    {
        b.ToTable("doctors", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.UserId)
            .HasColumnName("user_id")
            .IsRequired();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

        b.Property(x => x.Salutation)
            .HasColumnName("salutation")
            .HasMaxLength(DoctorConsts.MaxSalutationLength);

        b.Property(x => x.Gender)
            .HasColumnName("gender")
            .HasMaxLength(DoctorConsts.MaxGenderLength);

        b.Property(x => x.Specialization)
            .HasColumnName("specialization")
            .HasMaxLength(DoctorConsts.MaxSpecializationLength);

        b.Property(x => x.RegistrationNumber)
            .HasColumnName("registration_number")
            .HasMaxLength(DoctorConsts.MaxRegistrationNumberLength);

        b.Property(x => x.CreationTime)
            .HasColumnName("creation_time")
            .IsRequired();

        b.HasIndex(x => x.UserId).IsUnique();
    }

    private static void ConfigureFamilyLink(EntityTypeBuilder<FamilyLink> b)
    {
        b.ToTable("family_links", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.TenantId)
            .HasColumnName("tenant_id");

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
            .IsRequired()
            .HasDefaultValue(false);

        b.Property(x => x.CreationTime)
            .HasColumnName("creation_time")
            .IsRequired();

        b.HasIndex(x => x.TenantId);

        b.HasIndex(x => x.FamilyUserId);

        b.HasOne<Patient>()
            .WithMany()
            .HasForeignKey(x => x.PatientId)
            .OnDelete(DeleteBehavior.Cascade);

        b.HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(x => x.FamilyUserId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
