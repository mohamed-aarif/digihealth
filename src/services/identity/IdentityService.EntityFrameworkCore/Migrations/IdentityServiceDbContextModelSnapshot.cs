using System;
using IdentityService.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

#nullable disable

namespace IdentityService.EntityFrameworkCore.Migrations
{
    [DbContext(typeof(IdentityServiceDbContext))]
    partial class IdentityServiceDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasDefaultSchema("identity")
                .HasAnnotation("ProductVersion", "8.0.5");

            modelBuilder.Entity("IdentityService.Doctors.Doctor", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("creation_time");

                b.Property<string>("Gender")
                    .HasMaxLength(20)
                    .HasColumnType("character varying(20)")
                    .HasColumnName("gender");

                b.Property<string>("RegistrationNumber")
                    .HasMaxLength(80)
                    .HasColumnType("character varying(80)")
                    .HasColumnName("registration_number");

                b.Property<string>("Salutation")
                    .HasMaxLength(32)
                    .HasColumnType("character varying(32)")
                    .HasColumnName("salutation");

                b.Property<string>("Specialization")
                    .HasMaxLength(120)
                    .HasColumnType("character varying(120)")
                    .HasColumnName("specialization");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("tenant_id");

                b.Property<Guid>("UserId")
                    .HasColumnType("uuid")
                    .HasColumnName("user_id");

                b.HasKey("Id");

                b.HasIndex("UserId")
                    .IsUnique();

                b.ToTable("doctors", "identity");
            });

            modelBuilder.Entity("IdentityService.Patients.Patient", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("creation_time");

                b.Property<DateTime?>("DateOfBirth")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("date_of_birth");

                b.Property<string>("Gender")
                    .HasMaxLength(20)
                    .HasColumnType("character varying(20)")
                    .HasColumnName("gender");

                b.Property<string>("ResidenceCountry")
                    .HasMaxLength(120)
                    .HasColumnType("character varying(120)")
                    .HasColumnName("residence_country");

                b.Property<string>("Salutation")
                    .HasMaxLength(32)
                    .HasColumnType("character varying(32)")
                    .HasColumnName("salutation");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("tenant_id");

                b.Property<Guid>("UserId")
                    .HasColumnType("uuid")
                    .HasColumnName("user_id");

                b.HasKey("Id");

                b.HasIndex("UserId")
                    .IsUnique();

                b.ToTable("patients", "identity");
            });

            modelBuilder.Entity("Volo.Abp.PermissionManagement.PermissionDefinitionRecord", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("DisplayName")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("ExtraProperties")
                    .HasColumnType("text");

                b.Property<string>("GroupName")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<bool>("IsEnabled")
                    .HasColumnType("boolean");

                b.Property<string>("Name")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<string>("ParentName")
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<string>("Providers")
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<string>("StateCheckers")
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<byte>("MultiTenancySide")
                    .HasColumnType("smallint");

                b.HasKey("Id");

                b.HasIndex("GroupName");

                b.HasIndex("Name")
                    .IsUnique();

                b.ToTable("AbpPermissions", "identity");
            });

            modelBuilder.Entity("Volo.Abp.PermissionManagement.PermissionGrant", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("Name")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<string>("ProviderKey")
                    .IsRequired()
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("ProviderName")
                    .IsRequired()
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.HasIndex("TenantId", "Name", "ProviderName", "ProviderKey")
                    .IsUnique();

                b.ToTable("AbpPermissionGrants", "identity");
            });

            modelBuilder.Entity("Volo.Abp.PermissionManagement.PermissionGroupDefinitionRecord", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("DisplayName")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("ExtraProperties")
                    .HasColumnType("text");

                b.Property<string>("Name")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.HasKey("Id");

                b.HasIndex("Name")
                    .IsUnique();

                b.ToTable("AbpPermissionGroups", "identity");
            });
#pragma warning restore 612, 618
        }
    }
}
