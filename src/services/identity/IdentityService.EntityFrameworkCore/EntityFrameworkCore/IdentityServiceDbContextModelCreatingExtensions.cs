using IdentityService.Doctors;
using IdentityService.Patients;
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

        builder.Entity<Patient>(ConfigurePatient);
        builder.Entity<Doctor>(ConfigureDoctor);
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
}
