using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using IdentityService.Users;
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
        builder.Entity<UserProfile>(ConfigureUserProfile);
    }

    private static void ConfigurePatient(EntityTypeBuilder<Patient> b)
    {
        b.ToTable("patients", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.Id).HasColumnName("id");
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
            .IsRequired()
            .HasDefaultValueSql("now()");

        b.Property(x => x.LastModificationTime).HasColumnName("LastModificationTime");
        b.Property(x => x.LastModifierId).HasColumnName("LastModifierId");
        b.Property(x => x.CreatorId).HasColumnName("CreatorId");
        b.Property(x => x.IsDeleted).HasColumnName("IsDeleted");
        b.Property(x => x.DeleterId).HasColumnName("DeleterId");
        b.Property(x => x.DeletionTime).HasColumnName("DeletionTime");
        b.Property(x => x.ConcurrencyStamp)
            .HasColumnName("ConcurrencyStamp")
            .HasMaxLength(40)
            .IsConcurrencyToken();
        b.Property(x => x.ExtraProperties).HasColumnName("ExtraProperties");

        b.HasIndex(x => x.UserId).HasDatabaseName("ix_identity_patients_user_id");
        b.HasIndex(x => x.TenantId).HasDatabaseName("ix_identity_patients_tenant");
        b.HasIndex(x => x.DateOfBirth).HasDatabaseName("ix_identity_patients_dob");

        b.HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigureDoctor(EntityTypeBuilder<Doctor> b)
    {
        b.ToTable("doctors", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.Id).HasColumnName("id");
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
            .IsRequired()
            .HasDefaultValueSql("now()");
        b.Property(x => x.LastModificationTime).HasColumnName("LastModificationTime");
        b.Property(x => x.LastModifierId).HasColumnName("LastModifierId");
        b.Property(x => x.CreatorId).HasColumnName("CreatorId");
        b.Property(x => x.IsDeleted).HasColumnName("IsDeleted");
        b.Property(x => x.DeleterId).HasColumnName("DeleterId");
        b.Property(x => x.DeletionTime).HasColumnName("DeletionTime");
        b.Property(x => x.ConcurrencyStamp)
            .HasColumnName("ConcurrencyStamp")
            .HasMaxLength(40)
            .IsConcurrencyToken();
        b.Property(x => x.ExtraProperties).HasColumnName("ExtraProperties");

        b.HasIndex(x => x.UserId).HasDatabaseName("ix_identity_doctors_user_id");
        b.HasIndex(x => x.TenantId).HasDatabaseName("ix_identity_doctors_tenant");
        b.HasIndex(x => x.Specialization).HasDatabaseName("ix_identity_doctors_specialization");

        b.HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigureFamilyLink(EntityTypeBuilder<FamilyLink> b)
    {
        b.ToTable("family_links", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.Id).HasColumnName("id");
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
            .IsRequired()
            .HasDefaultValueSql("now()");

        b.Property(x => x.LastModificationTime).HasColumnName("LastModificationTime");
        b.Property(x => x.LastModifierId).HasColumnName("LastModifierId");
        b.Property(x => x.CreatorId).HasColumnName("CreatorId");
        b.Property(x => x.IsDeleted).HasColumnName("IsDeleted");
        b.Property(x => x.DeleterId).HasColumnName("DeleterId");
        b.Property(x => x.DeletionTime).HasColumnName("DeletionTime");
        b.Property(x => x.ConcurrencyStamp)
            .HasColumnName("ConcurrencyStamp")
            .HasMaxLength(40)
            .IsConcurrencyToken();
        b.Property(x => x.ExtraProperties).HasColumnName("ExtraProperties");

        b.HasIndex(x => x.TenantId);

        b.HasIndex(x => x.FamilyUserId);

        b.HasOne<Patient>()
            .WithMany()
            .HasForeignKey(x => x.PatientId)
            .OnDelete(DeleteBehavior.Restrict);

        b.HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(x => x.FamilyUserId)
            .OnDelete(DeleteBehavior.Cascade);
    }

    private static void ConfigureUserProfile(EntityTypeBuilder<UserProfile> b)
    {
        b.ToTable("users", IdentityServiceDbProperties.DbSchema);
        b.ConfigureByConvention();

        b.Property(x => x.Id).HasColumnName("id");
        b.Property(x => x.TenantId).HasColumnName("tenant_id");
        b.Property(x => x.UserName)
            .HasColumnName("user_name")
            .IsRequired()
            .HasMaxLength(256);
        b.Property(x => x.Email)
            .HasColumnName("email")
            .IsRequired()
            .HasMaxLength(256);
        b.Property(x => x.Salutation)
            .HasColumnName("salutation")
            .HasMaxLength(IdentityUserExtensionConsts.MaxSalutationLength);
        b.Property(x => x.ProfilePhotoUrl)
            .HasColumnName("profile_photo_url")
            .HasMaxLength(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength);
        b.Property(x => x.Name)
            .HasColumnName("name")
            .HasMaxLength(IdentityUserExtensionConsts.MaxNameLength);
        b.Property(x => x.Surname)
            .HasColumnName("surname")
            .HasMaxLength(IdentityUserExtensionConsts.MaxSurnameLength);
        b.Property(x => x.IsActive)
            .HasColumnName("is_active")
            .IsRequired()
            .HasDefaultValue(true);
        b.Property(x => x.CreationTime)
            .HasColumnName("creation_time")
            .IsRequired()
            .HasDefaultValueSql("now()");
        b.Property(x => x.LastModificationTime).HasColumnName("LastModificationTime");
        b.Property(x => x.LastModifierId).HasColumnName("LastModifierId");
        b.Property(x => x.CreatorId).HasColumnName("CreatorId");
        b.Property(x => x.IsDeleted).HasColumnName("IsDeleted");
        b.Property(x => x.DeleterId).HasColumnName("DeleterId");
        b.Property(x => x.DeletionTime).HasColumnName("DeletionTime");
        b.Property(x => x.ConcurrencyStamp)
            .HasColumnName("ConcurrencyStamp")
            .HasMaxLength(40)
            .IsConcurrencyToken();
        b.Property(x => x.ExtraProperties).HasColumnName("ExtraProperties");

        b.HasIndex(x => x.TenantId).HasDatabaseName("ix_identity_users_tenant");
        b.HasIndex(x => new { x.TenantId, x.UserName }).IsUnique().HasDatabaseName("ux_identity_users_username_tenant");

        b.HasOne<IdentityUser>()
            .WithOne()
            .HasForeignKey<UserProfile>(x => x.Id)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
