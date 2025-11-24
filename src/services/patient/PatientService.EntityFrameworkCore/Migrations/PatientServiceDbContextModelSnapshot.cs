using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using PatientService.EntityFrameworkCore;

#nullable disable

namespace PatientService.EntityFrameworkCore.Migrations
{
    [DbContext(typeof(PatientServiceDbContext))]
    partial class PatientServiceDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.6")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            modelBuilder.HasDefaultSchema("patient");

            modelBuilder.Entity("PatientService.Patients.PatientExternalLink", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasMaxLength(40)
                        .HasColumnType("character varying(40)");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("CreatorId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("DeleterId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("DeletionTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ExternalReference")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("ExtraProperties")
                        .HasColumnType("text");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("LastModificationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("LastModifierId")
                        .HasColumnType("uuid");

                    b.Property<string>("SystemName")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("IdentityPatientId", "SystemName", "TenantId")
                        .IsUnique();

                    b.ToTable("patient_external_links", "patient");
                });

            modelBuilder.Entity("PatientService.Patients.PatientMedicalSummary", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Allergies")
                        .HasMaxLength(512)
                        .HasColumnType("character varying(512)");

                    b.Property<string>("BloodGroup")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)");

                    b.Property<string>("ChronicConditions")
                        .HasMaxLength(512)
                        .HasColumnType("character varying(512)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasMaxLength(40)
                        .HasColumnType("character varying(40)");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("CreatorId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("DeleterId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("DeletionTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("ExtraProperties")
                        .HasColumnType("text");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("LastModificationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("LastModifierId")
                        .HasColumnType("uuid");

                    b.Property<string>("Notes")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("IdentityPatientId", "TenantId")
                        .IsUnique();

                    b.ToTable("patient_medical_summaries", "patient");
                });

            modelBuilder.Entity("PatientService.Patients.PatientProfileExtension", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("AddressLine1")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("AddressLine2")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("City")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasMaxLength(40)
                        .HasColumnType("character varying(40)");

                    b.Property<string>("Country")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("CreatorId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("DeleterId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("DeletionTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("EmergencyContactName")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("EmergencyContactNumber")
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("ExtraProperties")
                        .HasColumnType("text");

                    b.Property<Guid>("IdentityPatientId")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("LastModificationTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid?>("LastModifierId")
                        .HasColumnType("uuid");

                    b.Property<string>("PreferredLanguage")
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("PrimaryContactNumber")
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("SecondaryContactNumber")
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("State")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<Guid?>("TenantId")
                        .HasColumnType("uuid");

                    b.Property<string>("ZipCode")
                        .HasMaxLength(32)
                        .HasColumnType("character varying(32)");

                    b.HasKey("Id");

                    b.HasIndex("IdentityPatientId", "TenantId")
                        .IsUnique();

                    b.ToTable("patient_profile_extensions", "patient");
                });
#pragma warning restore 612, 618
        }
    }
}
