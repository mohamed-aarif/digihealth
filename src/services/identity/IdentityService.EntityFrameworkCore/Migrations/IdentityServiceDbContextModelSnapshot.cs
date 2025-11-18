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

            modelBuilder.Entity("Volo.Abp.Identity.IdentityClaimType", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("ConcurrencyStamp")
                    .IsConcurrencyToken()
                    .IsRequired()
                    .HasMaxLength(40)
                    .HasColumnType("character varying(40)")
                    .HasColumnName("ConcurrencyStamp");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<string>("Description")
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("ExtraProperties")
                    .IsRequired()
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<bool>("IsStatic")
                    .HasColumnType("boolean");

                b.Property<string>("Name")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("Regex")
                    .HasMaxLength(512)
                    .HasColumnType("character varying(512)");

                b.Property<string>("RegexDescription")
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<bool>("Required")
                    .HasColumnType("boolean");

                b.Property<int>("ValueType")
                    .HasColumnType("integer");

                b.HasKey("Id");

                b.HasIndex("Name")
                    .IsUnique();

                b.ToTable("AbpClaimTypes", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityLinkUser", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<Guid?>("SourceTenantId")
                    .HasColumnType("uuid");

                b.Property<Guid>("SourceUserId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TargetTenantId")
                    .HasColumnType("uuid");

                b.Property<Guid>("TargetUserId")
                    .HasColumnType("uuid");

                b.HasKey("Id");

                b.HasIndex("SourceUserId", "SourceTenantId", "TargetUserId", "TargetTenantId")
                    .IsUnique();

                b.ToTable("AbpLinkUsers", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityRole", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("ConcurrencyStamp")
                    .IsConcurrencyToken()
                    .IsRequired()
                    .HasMaxLength(40)
                    .HasColumnType("character varying(40)")
                    .HasColumnName("ConcurrencyStamp");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<int>("EntityVersion")
                    .HasColumnType("integer");

                b.Property<string>("ExtraProperties")
                    .IsRequired()
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<bool>("IsDefault")
                    .HasColumnType("boolean")
                    .HasColumnName("IsDefault");

                b.Property<bool>("IsPublic")
                    .HasColumnType("boolean")
                    .HasColumnName("IsPublic");

                b.Property<bool>("IsStatic")
                    .HasColumnType("boolean")
                    .HasColumnName("IsStatic");

                b.Property<string>("Name")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("NormalizedName")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.HasIndex("NormalizedName");

                b.ToTable("AbpRoles", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityRoleClaim", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("ClaimType")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("ClaimValue")
                    .HasMaxLength(1024)
                    .HasColumnType("character varying(1024)");

                b.Property<Guid>("RoleId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.HasIndex("RoleId");

                b.ToTable("AbpRoleClaims", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentitySecurityLog", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("Action")
                    .HasMaxLength(96)
                    .HasColumnType("character varying(96)");

                b.Property<string>("ApplicationName")
                    .HasMaxLength(96)
                    .HasColumnType("character varying(96)");

                b.Property<string>("BrowserInfo")
                    .HasMaxLength(512)
                    .HasColumnType("character varying(512)");

                b.Property<string>("ClientId")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("ClientIpAddress")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("ConcurrencyStamp")
                    .IsConcurrencyToken()
                    .IsRequired()
                    .HasMaxLength(40)
                    .HasColumnType("character varying(40)")
                    .HasColumnName("ConcurrencyStamp");

                b.Property<string>("CorrelationId")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone");

                b.Property<string>("ExtraProperties")
                    .IsRequired()
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<string>("Identity")
                    .HasMaxLength(96)
                    .HasColumnType("character varying(96)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.Property<string>("TenantName")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<Guid?>("UserId")
                    .HasColumnType("uuid");

                b.Property<string>("UserName")
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.HasKey("Id");

                b.HasIndex("TenantId", "Action");

                b.HasIndex("TenantId", "ApplicationName");

                b.HasIndex("TenantId", "Identity");

                b.HasIndex("TenantId", "UserId");

                b.ToTable("AbpSecurityLogs", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentitySession", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("ClientId")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("Device")
                    .IsRequired()
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("DeviceInfo")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("ExtraProperties")
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<string>("IpAddresses")
                    .HasMaxLength(2048)
                    .HasColumnType("character varying(2048)");

                b.Property<DateTime?>("LastAccessed")
                    .HasColumnType("timestamp without time zone");

                b.Property<string>("SessionId")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<DateTime>("SignedIn")
                    .HasColumnType("timestamp without time zone");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.HasKey("Id");

                b.HasIndex("Device");

                b.HasIndex("SessionId");

                b.HasIndex("TenantId", "UserId");

                b.ToTable("AbpSessions", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUser", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<int>("AccessFailedCount")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("integer")
                    .HasDefaultValue(0)
                    .HasColumnName("AccessFailedCount");

                b.Property<string>("ConcurrencyStamp")
                    .IsConcurrencyToken()
                    .IsRequired()
                    .HasMaxLength(40)
                    .HasColumnType("character varying(40)")
                    .HasColumnName("ConcurrencyStamp");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<Guid?>("CreatorId")
                    .HasColumnType("uuid")
                    .HasColumnName("CreatorId");

                b.Property<Guid?>("DeleterId")
                    .HasColumnType("uuid")
                    .HasColumnName("DeleterId");

                b.Property<DateTime?>("DeletionTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("DeletionTime");

                b.Property<string>("Email")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("Email");

                b.Property<bool>("EmailConfirmed")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("EmailConfirmed");

                b.Property<int>("EntityVersion")
                    .HasColumnType("integer");

                b.Property<string>("ExtraProperties")
                    .IsRequired()
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<bool>("IsActive")
                    .HasColumnType("boolean")
                    .HasColumnName("IsActive");

                b.Property<bool>("IsDeleted")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("IsDeleted");

                b.Property<bool>("IsExternal")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("IsExternal");

                b.Property<bool>("LockoutEnabled")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("LockoutEnabled");

                b.Property<DateTimeOffset?>("LockoutEnd")
                    .HasColumnType("timestamp with time zone")
                    .HasColumnName("LockoutEnd");

                b.Property<string>("Name")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("NormalizedEmail")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("NormalizedEmail");

                b.Property<string>("NormalizedUserName")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("NormalizedUserName");

                b.Property<string>("PasswordHash")
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("PasswordHash");

                b.Property<string>("PhoneNumber")
                    .HasMaxLength(16)
                    .HasColumnType("character varying(16)")
                    .HasColumnName("PhoneNumber");

                b.Property<bool>("PhoneNumberConfirmed")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("PhoneNumberConfirmed");

                b.Property<string>("SecurityStamp")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("SecurityStamp");

                b.Property<bool>("ShouldChangePasswordOnNextLogin")
                    .HasColumnType("boolean")
                    .HasColumnName("ShouldChangePasswordOnNextLogin");

                b.Property<string>("Surname")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.Property<bool>("TwoFactorEnabled")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("TwoFactorEnabled");

                b.Property<string>("UserName")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)")
                    .HasColumnName("UserName");

                b.HasKey("Id");

                b.HasIndex("Email");

                b.HasIndex("NormalizedEmail");

                b.HasIndex("NormalizedUserName");

                b.HasIndex("UserName");

                b.ToTable("AbpUsers", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserClaim", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("ClaimType")
                    .IsRequired()
                    .HasMaxLength(256)
                    .HasColumnType("character varying(256)");

                b.Property<string>("ClaimValue")
                    .HasMaxLength(1024)
                    .HasColumnType("character varying(1024)");

                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.HasIndex("UserId");

                b.ToTable("AbpUserClaims", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserDelegation", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<DateTime>("EndTime")
                    .HasColumnType("timestamp without time zone");

                b.Property<Guid>("SourceUserId")
                    .HasColumnType("uuid");

                b.Property<DateTime>("StartTime")
                    .HasColumnType("timestamp without time zone");

                b.Property<Guid>("TargetUserId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.ToTable("AbpUserDelegations", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserLogin", b =>
            {
                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.Property<string>("LoginProvider")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("ProviderDisplayName")
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<string>("ProviderKey")
                    .IsRequired()
                    .HasMaxLength(196)
                    .HasColumnType("character varying(196)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("UserId", "LoginProvider");

                b.HasIndex("LoginProvider", "ProviderKey");

                b.ToTable("AbpUserLogins", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserOrganizationUnit", b =>
            {
                b.Property<Guid>("OrganizationUnitId")
                    .HasColumnType("uuid");

                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<Guid?>("CreatorId")
                    .HasColumnType("uuid")
                    .HasColumnName("CreatorId");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("OrganizationUnitId", "UserId");

                b.HasIndex("UserId", "OrganizationUnitId");

                b.ToTable("AbpUserOrganizationUnits", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserRole", b =>
            {
                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.Property<Guid>("RoleId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("UserId", "RoleId");

                b.HasIndex("RoleId", "UserId");

                b.ToTable("AbpUserRoles", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserToken", b =>
            {
                b.Property<Guid>("UserId")
                    .HasColumnType("uuid");

                b.Property<string>("LoginProvider")
                    .HasMaxLength(64)
                    .HasColumnType("character varying(64)");

                b.Property<string>("Name")
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.Property<string>("Value")
                    .HasColumnType("text");

                b.HasKey("UserId", "LoginProvider", "Name");

                b.ToTable("AbpUserTokens", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.OrganizationUnit", b =>
            {
                b.Property<Guid>("Id")
                    .HasColumnType("uuid");

                b.Property<string>("Code")
                    .IsRequired()
                    .HasMaxLength(95)
                    .HasColumnType("character varying(95)")
                    .HasColumnName("Code");

                b.Property<string>("ConcurrencyStamp")
                    .IsConcurrencyToken()
                    .IsRequired()
                    .HasMaxLength(40)
                    .HasColumnType("character varying(40)")
                    .HasColumnName("ConcurrencyStamp");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<Guid?>("CreatorId")
                    .HasColumnType("uuid")
                    .HasColumnName("CreatorId");

                b.Property<Guid?>("DeleterId")
                    .HasColumnType("uuid")
                    .HasColumnName("DeleterId");

                b.Property<DateTime?>("DeletionTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("DeletionTime");

                b.Property<string>("DisplayName")
                    .IsRequired()
                    .HasMaxLength(128)
                    .HasColumnType("character varying(128)")
                    .HasColumnName("DisplayName");

                b.Property<int>("EntityVersion")
                    .HasColumnType("integer");

                b.Property<string>("ExtraProperties")
                    .IsRequired()
                    .HasColumnType("text")
                    .HasColumnName("ExtraProperties");

                b.Property<bool>("IsDeleted")
                    .ValueGeneratedOnAdd()
                    .HasColumnType("boolean")
                    .HasDefaultValue(false)
                    .HasColumnName("IsDeleted");

                b.Property<DateTime?>("LastModificationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("LastModificationTime");

                b.Property<Guid?>("LastModifierId")
                    .HasColumnType("uuid")
                    .HasColumnName("LastModifierId");

                b.Property<Guid?>("ParentId")
                    .HasColumnType("uuid");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("Id");

                b.HasIndex("Code");

                b.HasIndex("ParentId");

                b.ToTable("AbpOrganizationUnits", "identity");
            });

            modelBuilder.Entity("Volo.Abp.Identity.OrganizationUnitRole", b =>
            {
                b.Property<Guid>("OrganizationUnitId")
                    .HasColumnType("uuid");

                b.Property<Guid>("RoleId")
                    .HasColumnType("uuid");

                b.Property<DateTime>("CreationTime")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("CreationTime");

                b.Property<Guid?>("CreatorId")
                    .HasColumnType("uuid")
                    .HasColumnName("CreatorId");

                b.Property<Guid?>("TenantId")
                    .HasColumnType("uuid")
                    .HasColumnName("TenantId");

                b.HasKey("OrganizationUnitId", "RoleId");

                b.HasIndex("RoleId", "OrganizationUnitId");

                b.ToTable("AbpOrganizationUnitRoles", "identity");
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

            modelBuilder.Entity("Volo.Abp.Identity.IdentityRoleClaim", b =>
            {
                b.HasOne("Volo.Abp.Identity.IdentityRole", null)
                    .WithMany()
                    .HasForeignKey("RoleId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserClaim", b =>
            {
                b.HasOne("Volo.Abp.Identity.IdentityUser", null)
                    .WithMany()
                    .HasForeignKey("UserId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserLogin", b =>
            {
                b.HasOne("Volo.Abp.Identity.IdentityUser", null)
                    .WithMany()
                    .HasForeignKey("UserId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserOrganizationUnit", b =>
            {
                b.HasOne("Volo.Abp.Identity.OrganizationUnit", null)
                    .WithMany()
                    .HasForeignKey("OrganizationUnitId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();

                b.HasOne("Volo.Abp.Identity.IdentityUser", null)
                    .WithMany()
                    .HasForeignKey("UserId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserRole", b =>
            {
                b.HasOne("Volo.Abp.Identity.IdentityRole", null)
                    .WithMany()
                    .HasForeignKey("RoleId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();

                b.HasOne("Volo.Abp.Identity.IdentityUser", null)
                    .WithMany()
                    .HasForeignKey("UserId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.IdentityUserToken", b =>
            {
                b.HasOne("Volo.Abp.Identity.IdentityUser", null)
                    .WithMany()
                    .HasForeignKey("UserId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });

            modelBuilder.Entity("Volo.Abp.Identity.OrganizationUnit", b =>
            {
                b.HasOne("Volo.Abp.Identity.OrganizationUnit", null)
                    .WithMany()
                    .HasForeignKey("ParentId");
            });

            modelBuilder.Entity("Volo.Abp.Identity.OrganizationUnitRole", b =>
            {
                b.HasOne("Volo.Abp.Identity.OrganizationUnit", null)
                    .WithMany()
                    .HasForeignKey("OrganizationUnitId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();

                b.HasOne("Volo.Abp.Identity.IdentityRole", null)
                    .WithMany()
                    .HasForeignKey("RoleId")
                    .OnDelete(DeleteBehavior.Cascade)
                    .IsRequired();
            });
#pragma warning restore 612, 618
        }
    }
}
