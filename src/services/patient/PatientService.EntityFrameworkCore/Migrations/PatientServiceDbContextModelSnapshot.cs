using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using PatientService.EntityFrameworkCore;

#nullable disable

namespace PatientService.Migrations
{
    [DbContext(typeof(PatientServiceDbContext))]
    partial class PatientServiceDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasDefaultSchema("patient")
                .HasAnnotation("ProductVersion", "8.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("PatientService.ExternalLinks.PatientExternalLink", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid")
                        .HasColumnName("id");

                    b.Property<string>("ExternalReference")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)")
                        .HasColumnName("external_reference");

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid")
                        .HasColumnName("identity_patient_id");

                    b.Property<string>("SystemName")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)")
                        .HasColumnName("system_name");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid")
                        .HasColumnName("tenant_id");

                    b.HasKey("Id");

                    b.HasIndex("TenantId");

                    b.HasIndex("IdentityPatientId", "SystemName")
                        .IsUnique();

                    b.ToTable("patient_external_links", "patient");
                });

            modelBuilder.Entity("PatientService.MedicalSummaries.PatientMedicalSummary", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid")
                        .HasColumnName("id");

                    b.Property<string>("Allergies")
                        .HasMaxLength(512)
                        .HasColumnType("character varying(512)")
                        .HasColumnName("allergies");

                    b.Property<string>("BloodGroup")
                        .HasMaxLength(8)
                        .HasColumnType("character varying(8)")
                        .HasColumnName("blood_group");

                    b.Property<string>("ChronicConditions")
                        .HasMaxLength(512)
                        .HasColumnType("character varying(512)")
                        .HasColumnName("chronic_conditions");

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid")
                        .HasColumnName("identity_patient_id");

                    b.Property<string>("Notes")
                        .HasMaxLength(2000)
                        .HasColumnType("character varying(2000)")
                        .HasColumnName("notes");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid")
                        .HasColumnName("tenant_id");

                    b.HasKey("Id");

                    b.HasIndex("TenantId");

                    b.HasIndex("IdentityPatientId")
                        .IsUnique();

                    b.ToTable("patient_medical_summaries", "patient");
                });

            modelBuilder.Entity("PatientService.PatientProfiles.PatientProfileExtension", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid")
                        .HasColumnName("id");

                    b.Property<string>("AddressLine1")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)")
                        .HasColumnName("address_line1");

                    b.Property<string>("AddressLine2")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)")
                        .HasColumnName("address_line2");

                    b.Property<string>("City")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)")
                        .HasColumnName("city");

                    b.Property<string>("Country")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)")
                        .HasColumnName("country");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)")
                        .HasColumnName("email");

                    b.Property<string>("EmergencyContactName")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)")
                        .HasColumnName("emergency_contact_name");

                    b.Property<string>("EmergencyContactNumber")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)")
                        .HasColumnName("emergency_contact_number");

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid")
                        .HasColumnName("identity_patient_id");

                    b.Property<string>("PreferredLanguage")
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)")
                        .HasColumnName("preferred_language");

                    b.Property<string>("PrimaryContactNumber")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)")
                        .HasColumnName("primary_contact_number");

                    b.Property<string>("SecondaryContactNumber")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)")
                        .HasColumnName("secondary_contact_number");

                    b.Property<string>("State")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)")
                        .HasColumnName("state");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid")
                        .HasColumnName("tenant_id");

                    b.Property<string>("ZipCode")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)")
                        .HasColumnName("zip_code");

                    b.HasKey("Id");

                    b.HasIndex("TenantId");

                    b.HasIndex("IdentityPatientId")
                        .IsUnique();

                    b.ToTable("patient_profile_extensions", "patient");
                });
#pragma warning restore 612, 618
        }
    }
}
