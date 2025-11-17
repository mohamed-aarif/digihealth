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
#pragma warning restore 612, 618
        }
    }
}
