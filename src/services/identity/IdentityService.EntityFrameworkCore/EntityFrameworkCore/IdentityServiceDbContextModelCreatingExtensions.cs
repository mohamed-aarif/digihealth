using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Volo.Abp;

namespace IdentityService.EntityFrameworkCore;

public static class IdentityServiceDbContextModelCreatingExtensions
{
    public static void ConfigureIdentityService(this ModelBuilder builder)
    {
        Check.NotNull(builder, nameof(builder));

        builder.Entity<Patient>(b =>
        {
            b.ToTable("patients", IdentityServiceDbProperties.DbSchema);
            b.ConfigureByConvention();

            b.Property(x => x.IdentityUserId).IsRequired();
            b.Property(x => x.MedicalRecordNumber).IsRequired().HasMaxLength(PatientConsts.MaxMedicalRecordNumberLength);
            b.Property(x => x.FirstName).IsRequired().HasMaxLength(PatientConsts.MaxNameLength);
            b.Property(x => x.LastName).IsRequired().HasMaxLength(PatientConsts.MaxNameLength);
            b.Property(x => x.PhoneNumber).HasMaxLength(PatientConsts.MaxPhoneLength);
            b.Property(x => x.Email).HasMaxLength(PatientConsts.MaxEmailLength);

            b.HasIndex(x => x.MedicalRecordNumber).IsUnique();
            b.HasIndex(x => x.IdentityUserId).IsUnique();

            b.HasOne<Doctor>()
                .WithMany()
                .HasForeignKey(x => x.PrimaryDoctorId)
                .OnDelete(DeleteBehavior.SetNull);
        });

        builder.Entity<Doctor>(b =>
        {
            b.ToTable("doctors", IdentityServiceDbProperties.DbSchema);
            b.ConfigureByConvention();

            b.Property(x => x.IdentityUserId).IsRequired();
            b.Property(x => x.LicenseNumber).IsRequired().HasMaxLength(DoctorConsts.MaxLicenseNumberLength);
            b.Property(x => x.FirstName).IsRequired().HasMaxLength(DoctorConsts.MaxNameLength);
            b.Property(x => x.LastName).IsRequired().HasMaxLength(DoctorConsts.MaxNameLength);
            b.Property(x => x.Specialty).HasMaxLength(DoctorConsts.MaxSpecialtyLength);

            b.HasIndex(x => x.IdentityUserId).IsUnique();
            b.HasIndex(x => x.LicenseNumber).IsUnique();
        });

        builder.Entity<FamilyLink>(b =>
        {
            b.ToTable("family_links", IdentityServiceDbProperties.DbSchema);
            b.ConfigureByConvention();

            b.Property(x => x.PatientId).IsRequired();
            b.Property(x => x.RelatedPatientId).IsRequired();
            b.Property(x => x.Relationship).IsRequired().HasMaxLength(FamilyLinkConsts.MaxRelationshipLength);

            b.HasIndex(x => new { x.PatientId, x.RelatedPatientId }).IsUnique();
        });
    }
}
