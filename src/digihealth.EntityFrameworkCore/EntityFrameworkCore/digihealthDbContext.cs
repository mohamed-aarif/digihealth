using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL;
using Volo.Abp.AuditLogging.EntityFrameworkCore;
using Volo.Abp.BackgroundJobs.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.FeatureManagement.EntityFrameworkCore;
using Volo.Abp.Identity;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.OpenIddict.EntityFrameworkCore;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;
using Volo.Abp.SettingManagement.EntityFrameworkCore;
using Volo.Abp.TenantManagement;
using Volo.Abp.TenantManagement.EntityFrameworkCore;

namespace digihealth.EntityFrameworkCore;

[ReplaceDbContext(typeof(IIdentityDbContext))]
[ReplaceDbContext(typeof(ITenantManagementDbContext))]
[ConnectionStringName("Default")]
public class digihealthDbContext :
    AbpDbContext<digihealthDbContext>,
    IIdentityDbContext,
    ITenantManagementDbContext
{
    /* Add DbSet properties for your Aggregate Roots / Entities here. */
    public DbSet<IdentityUserEntity> IdentityUsers => Set<IdentityUserEntity>();
    public DbSet<PatientEntity> Patients => Set<PatientEntity>();
    public DbSet<DoctorEntity> Doctors => Set<DoctorEntity>();
    public DbSet<FamilyLinkEntity> FamilyLinks => Set<FamilyLinkEntity>();
    public DbSet<PatientIdentifierEntity> PatientIdentifiers => Set<PatientIdentifierEntity>();
    public DbSet<PatientInsuranceEntity> PatientInsurances => Set<PatientInsuranceEntity>();

    public DbSet<VaultRecordEntity> VaultRecords => Set<VaultRecordEntity>();
    public DbSet<VaultTimelineEventEntity> VaultTimelineEvents => Set<VaultTimelineEventEntity>();

    public DbSet<ConsentSessionEntity> ConsentSessions => Set<ConsentSessionEntity>();
    public DbSet<ConsentAccessLogEntity> ConsentAccessLogs => Set<ConsentAccessLogEntity>();

    public DbSet<PrescriptionEntity> Prescriptions => Set<PrescriptionEntity>();
    public DbSet<MedicationItemEntity> MedicationItems => Set<MedicationItemEntity>();
    public DbSet<MedicationScheduleEntity> MedicationSchedules => Set<MedicationScheduleEntity>();
    public DbSet<MedicationDoseEntity> MedicationDoses => Set<MedicationDoseEntity>();

    public DbSet<AppointmentEntity> Appointments => Set<AppointmentEntity>();
    public DbSet<VisitNoteEntity> VisitNotes => Set<VisitNoteEntity>();
    public DbSet<AiVisitBriefEntity> AiVisitBriefs => Set<AiVisitBriefEntity>();

    public DbSet<DeviceLinkEntity> DeviceLinks => Set<DeviceLinkEntity>();
    public DbSet<VitalReadingEntity> VitalReadings => Set<VitalReadingEntity>();

    public DbSet<NotificationEntity> Notifications => Set<NotificationEntity>();
    public DbSet<ChatSessionEntity> ChatSessions => Set<ChatSessionEntity>();
    public DbSet<ChatMessageEntity> ChatMessages => Set<ChatMessageEntity>();

    #region Entities from the modules

    //Identity
    public DbSet<IdentityUser> Users { get; set; }
    public DbSet<IdentityRole> Roles { get; set; }
    public DbSet<IdentityClaimType> ClaimTypes { get; set; }
    public DbSet<OrganizationUnit> OrganizationUnits { get; set; }
    public DbSet<IdentitySecurityLog> SecurityLogs { get; set; }
    public DbSet<IdentityLinkUser> LinkUsers { get; set; }
    public DbSet<IdentityUserDelegation> UserDelegations { get; set; }
    public DbSet<IdentitySession> Sessions { get; set; }
    // Tenant Management
    public DbSet<Tenant> Tenants { get; set; }
    public DbSet<TenantConnectionString> TenantConnectionStrings { get; set; }

    #endregion

    public digihealthDbContext(DbContextOptions<digihealthDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.HasPostgresExtension("pgcrypto");

        ApplyUtcDateTimeConverter(builder);

        /* Include modules to your migration db context */

        builder.ConfigurePermissionManagement();
        builder.ConfigureSettingManagement();
        builder.ConfigureBackgroundJobs();
        builder.ConfigureAuditLogging();
        builder.ConfigureIdentity();
        builder.ConfigureOpenIddict();
        builder.ConfigureFeatureManagement();
        builder.ConfigureTenantManagement();

        /* Configure your own tables/entities inside here */

        ConfigureIdentitySchema(builder);
        ConfigureVaultSchema(builder);
        ConfigureConsentSchema(builder);
        ConfigureMedicationSchema(builder);
        ConfigureAppointmentsSchema(builder);
        ConfigureDevicesSchema(builder);
        ConfigureEngagementSchema(builder);
    }

    private static void ConfigureIdentitySchema(ModelBuilder builder)
    {
        builder.Entity<IdentityUserEntity>(b =>
        {
            b.ToTable("users", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.UserName)
                .HasColumnName("user_name")
                .HasMaxLength(64)
                .IsRequired();
            b.Property(x => x.Email)
                .HasColumnName("email")
                .HasMaxLength(256)
                .IsRequired();
            b.Property(x => x.PasswordHash)
                .HasColumnName("password_hash")
                .HasMaxLength(256)
                .IsRequired();
            b.Property(x => x.UserType)
                .HasColumnName("user_type")
                .HasMaxLength(20)
                .IsRequired();
            b.Property(x => x.PhotoStorageKey)
                .HasColumnName("photo_storage_key")
                .HasMaxLength(300);
            b.Property(x => x.IsActive)
                .HasColumnName("is_active")
                .HasDefaultValue(true)
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasIndex(x => x.UserName)
                .IsUnique()
                .HasDatabaseName("IX_identity_users_user_name");
            b.HasIndex(x => x.Email)
                .IsUnique()
                .HasDatabaseName("IX_identity_users_email");
        });

        builder.Entity<PatientEntity>(b =>
        {
            b.ToTable("patients", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.UserId)
                .HasColumnName("user_id")
                .IsRequired();
            b.Property(x => x.Salutation)
                .HasColumnName("salutation")
                .HasMaxLength(20);
            b.Property(x => x.FullName)
                .HasColumnName("full_name")
                .HasMaxLength(150)
                .IsRequired();
            b.Property(x => x.DateOfBirth)
                .HasColumnName("date_of_birth")
                .HasColumnType("date");
            b.Property(x => x.Gender)
                .HasColumnName("gender")
                .HasMaxLength(10);
            b.Property(x => x.Country)
                .HasColumnName("country")
                .HasMaxLength(80);
            b.Property(x => x.MobileNumber)
                .HasColumnName("mobile_number")
                .HasMaxLength(32);
            b.Property(x => x.HealthVaultId)
                .HasColumnName("healthvault_id")
                .HasMaxLength(32);
            b.Property(x => x.ResidenceCountry)
                .HasColumnName("residence_country")
                .HasMaxLength(80);
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<IdentityUserEntity>()
                .WithMany()
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_identity_patients_users");

            b.HasIndex(x => x.HealthVaultId)
                .IsUnique()
                .HasFilter("healthvault_id IS NOT NULL")
                .HasDatabaseName("UQ_identity_patients_healthvault_id");
        });

        builder.Entity<DoctorEntity>(b =>
        {
            b.ToTable("doctors", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.UserId)
                .HasColumnName("user_id")
                .IsRequired();
            b.Property(x => x.Salutation)
                .HasColumnName("salutation")
                .HasMaxLength(20);
            b.Property(x => x.FullName)
                .HasColumnName("full_name")
                .HasMaxLength(150)
                .IsRequired();
            b.Property(x => x.Gender)
                .HasColumnName("gender")
                .HasMaxLength(10);
            b.Property(x => x.Specialty)
                .HasColumnName("specialty")
                .HasMaxLength(120);
            b.Property(x => x.RegistrationNo)
                .HasColumnName("registration_no")
                .HasMaxLength(80);
            b.Property(x => x.ClinicName)
                .HasColumnName("clinic_name")
                .HasMaxLength(150);
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<IdentityUserEntity>()
                .WithMany()
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_identity_doctors_users");
        });

        builder.Entity<FamilyLinkEntity>(b =>
        {
            b.ToTable("family_links", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.FamilyUserId)
                .HasColumnName("family_user_id")
                .IsRequired();
            b.Property(x => x.Relationship)
                .HasColumnName("relationship")
                .HasMaxLength(50)
                .IsRequired();
            b.Property(x => x.IsGuardian)
                .HasColumnName("is_guardian")
                .HasDefaultValue(false)
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_identity_family_links_patients");

            b.HasOne<IdentityUserEntity>()
                .WithMany()
                .HasForeignKey(x => x.FamilyUserId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_identity_family_links_users");
        });

        builder.Entity<PatientIdentifierEntity>(b =>
        {
            b.ToTable("patient_identifiers", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.IdType)
                .HasColumnName("id_type")
                .HasMaxLength(30)
                .IsRequired();
            b.Property(x => x.IdNumber)
                .HasColumnName("id_number")
                .HasMaxLength(64)
                .IsRequired();
            b.Property(x => x.IssuerCountry)
                .HasColumnName("issuer_country")
                .HasMaxLength(2);
            b.Property(x => x.IssueDate)
                .HasColumnName("issue_date")
                .HasColumnType("date");
            b.Property(x => x.ExpiryDate)
                .HasColumnName("expiry_date")
                .HasColumnType("date");
            b.Property(x => x.Notes)
                .HasColumnName("notes");
            b.Property(x => x.RecordId)
                .HasColumnName("record_id");
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_identity_patient_identifiers_patients");

            b.HasOne<VaultRecordEntity>()
                .WithMany()
                .HasForeignKey(x => x.RecordId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_identity_patient_identifiers_records");

            b.HasIndex(x => new { x.PatientId, x.IdType, x.IdNumber })
                .IsUnique()
                .HasDatabaseName("uq_patient_identifier");

            b.HasIndex(x => x.PatientId)
                .HasDatabaseName("idx_patient_identifiers_patient");

            b.HasIndex(x => x.IdType)
                .HasDatabaseName("idx_patient_identifiers_type");
        });

        builder.Entity<PatientInsuranceEntity>(b =>
        {
            b.ToTable("patient_insurances", "identity");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.InsurerName)
                .HasColumnName("insurer_name")
                .HasMaxLength(150)
                .IsRequired();
            b.Property(x => x.PolicyNumber)
                .HasColumnName("policy_number")
                .HasMaxLength(64)
                .IsRequired();
            b.Property(x => x.MemberId)
                .HasColumnName("member_id")
                .HasMaxLength(64);
            b.Property(x => x.PlanName)
                .HasColumnName("plan_name")
                .HasMaxLength(150);
            b.Property(x => x.InsurerCountry)
                .HasColumnName("insurer_country")
                .HasMaxLength(2);
            b.Property(x => x.IssueDate)
                .HasColumnName("issue_date")
                .HasColumnType("date");
            b.Property(x => x.ExpiryDate)
                .HasColumnName("expiry_date")
                .HasColumnType("date");
            b.Property(x => x.IsActive)
                .HasColumnName("is_active")
                .HasDefaultValue(true)
                .IsRequired();
            b.Property(x => x.RecordId)
                .HasColumnName("record_id");
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_identity_patient_insurances_patients");

            b.HasOne<VaultRecordEntity>()
                .WithMany()
                .HasForeignKey(x => x.RecordId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_identity_patient_insurances_records");

            b.HasIndex(x => new { x.PatientId, x.PolicyNumber })
                .IsUnique()
                .HasDatabaseName("uq_patient_policy");

            b.HasIndex(x => x.PatientId)
                .HasDatabaseName("idx_patient_insurances_patient");

            b.HasIndex(x => x.IsActive)
                .HasDatabaseName("idx_patient_insurances_active");
        });
    }

    private static void ConfigureVaultSchema(ModelBuilder builder)
    {
        builder.Entity<VaultRecordEntity>(b =>
        {
            b.ToTable("records", "vault");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.RecordType)
                .HasColumnName("record_type")
                .HasColumnType("vault.record_type")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.Title)
                .HasColumnName("title")
                .HasMaxLength(200)
                .IsRequired();
            b.Property(x => x.Description)
                .HasColumnName("description");
            b.Property(x => x.FileStorageKey)
                .HasColumnName("file_storage_key")
                .HasMaxLength(300)
                .IsRequired();
            b.Property(x => x.Sensitivity)
                .HasColumnName("sensitivity")
                .HasColumnType("vault.sensitivity_level")
                .HasConversion<string>()
                .HasDefaultValueSql("'Restricted'::vault.sensitivity_level")
                .HasSentinel(VaultSensitivityLevel.Restricted)
                .IsRequired();
            b.Property(x => x.Source)
                .HasColumnName("source")
                .HasMaxLength(50);
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_vault_records_patients");
        });

        builder.Entity<VaultTimelineEventEntity>(b =>
        {
            b.ToTable("timeline_events", "vault");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.EventType)
                .HasColumnName("event_type")
                .HasColumnType("vault.event_type")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.RelatedId)
                .HasColumnName("related_id");
            b.Property(x => x.EventTime)
                .HasColumnName("event_time")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.Summary)
                .HasColumnName("summary")
                .HasMaxLength(300);
            b.Property(x => x.DetailsJson)
                .HasColumnName("details_json")
                .HasColumnType("jsonb");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_vault_timeline_events_patients");
        });
    }

    private static void ConfigureConsentSchema(ModelBuilder builder)
    {
        builder.Entity<ConsentSessionEntity>(b =>
        {
            b.ToTable("consent_sessions", "consent");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.ActorUserId)
                .HasColumnName("actor_user_id")
                .IsRequired();
            b.Property(x => x.ActorType)
                .HasColumnName("actor_type")
                .HasColumnType("consent.actor_type")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.ScopeJson)
                .HasColumnName("scope_json")
                .HasColumnType("jsonb")
                .IsRequired();
            b.Property(x => x.ExpiresAt)
                .HasColumnName("expires_at")
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.IsRevoked)
                .HasColumnName("is_revoked")
                .HasDefaultValue(false)
                .IsRequired();

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_consent_sessions_patients");

            b.HasOne<IdentityUserEntity>()
                .WithMany()
                .HasForeignKey(x => x.ActorUserId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_consent_sessions_users");
        });

        builder.Entity<ConsentAccessLogEntity>(b =>
        {
            b.ToTable("access_logs", "consent");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.ConsentSessionId)
                .HasColumnName("consent_session_id")
                .IsRequired();
            b.Property(x => x.AccessedAt)
                .HasColumnName("accessed_at")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.ResourceType)
                .HasColumnName("resource_type")
                .HasMaxLength(50);
            b.Property(x => x.ResourceId)
                .HasColumnName("resource_id");
            b.Property(x => x.Action)
                .HasColumnName("action")
                .HasMaxLength(20);

            b.HasOne<ConsentSessionEntity>()
                .WithMany()
                .HasForeignKey(x => x.ConsentSessionId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_consent_access_logs_sessions");
        });
    }

    private static void ConfigureMedicationSchema(ModelBuilder builder)
    {
        builder.Entity<PrescriptionEntity>(b =>
        {
            b.ToTable("prescriptions", "medication");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.DoctorId)
                .HasColumnName("doctor_id");
            b.Property(x => x.RecordId)
                .HasColumnName("record_id");
            b.Property(x => x.IssuedOn)
                .HasColumnName("issued_on")
                .HasColumnType("date")
                .IsRequired();
            b.Property(x => x.Notes)
                .HasColumnName("notes");
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_medication_prescriptions_patients");

            b.HasOne<DoctorEntity>()
                .WithMany()
                .HasForeignKey(x => x.DoctorId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_medication_prescriptions_doctors");

            b.HasOne<VaultRecordEntity>()
                .WithMany()
                .HasForeignKey(x => x.RecordId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_medication_prescriptions_records");
        });

        builder.Entity<MedicationItemEntity>(b =>
        {
            b.ToTable("medication_items", "medication");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PrescriptionId)
                .HasColumnName("prescription_id")
                .IsRequired();
            b.Property(x => x.Name)
                .HasColumnName("name")
                .HasMaxLength(150)
                .IsRequired();
            b.Property(x => x.Dosage)
                .HasColumnName("dosage")
                .HasMaxLength(80);
            b.Property(x => x.Frequency)
                .HasColumnName("frequency")
                .HasMaxLength(80);
            b.Property(x => x.Route)
                .HasColumnName("route")
                .HasMaxLength(50);
            b.Property(x => x.DurationDays)
                .HasColumnName("duration_days");
            b.Property(x => x.Instructions)
                .HasColumnName("instructions");

            b.HasOne<PrescriptionEntity>()
                .WithMany()
                .HasForeignKey(x => x.PrescriptionId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_medication_items_prescriptions");
        });

        builder.Entity<MedicationScheduleEntity>(b =>
        {
            b.ToTable("medication_schedules", "medication");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.MedicationItemId)
                .HasColumnName("medication_item_id")
                .IsRequired();
            b.Property(x => x.StartDate)
                .HasColumnName("start_date")
                .HasColumnType("date")
                .IsRequired();
            b.Property(x => x.EndDate)
                .HasColumnName("end_date")
                .HasColumnType("date");
            b.Property(x => x.TimesInDay)
                .HasColumnName("times_in_day")
                .HasColumnType("jsonb")
                .IsRequired();
            b.Property(x => x.Timezone)
                .HasColumnName("timezone")
                .HasMaxLength(64)
                .HasDefaultValue("Asia/Dubai")
                .IsRequired();

            b.HasOne<MedicationItemEntity>()
                .WithMany()
                .HasForeignKey(x => x.MedicationItemId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_medication_schedules_items");
        });

        builder.Entity<MedicationDoseEntity>(b =>
        {
            b.ToTable("medication_doses", "medication");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.ScheduleId)
                .HasColumnName("schedule_id")
                .IsRequired();
            b.Property(x => x.DueAt)
                .HasColumnName("due_at")
                .IsRequired();
            b.Property(x => x.Status)
                .HasColumnName("status")
                .HasColumnType("medication.dose_status")
                .HasConversion<string>()
                .HasDefaultValueSql("'Scheduled'::medication.dose_status")
                .HasSentinel(MedicationDoseStatus.Scheduled)
                .IsRequired();
            b.Property(x => x.TakenAt)
                .HasColumnName("taken_at");
            b.Property(x => x.Notes)
                .HasColumnName("notes");

            b.HasOne<MedicationScheduleEntity>()
                .WithMany()
                .HasForeignKey(x => x.ScheduleId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_medication_doses_schedules");
        });
    }

    private static void ConfigureAppointmentsSchema(ModelBuilder builder)
    {
        builder.Entity<AppointmentEntity>(b =>
        {
            b.ToTable("appointments", "appointments");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.DoctorId)
                .HasColumnName("doctor_id")
                .IsRequired();
            b.Property(x => x.ScheduledAt)
                .HasColumnName("scheduled_at")
                .IsRequired();
            b.Property(x => x.Status)
                .HasColumnName("status")
                .HasColumnType("appointments.appointment_status")
                .HasConversion<string>()
                .HasDefaultValueSql("'Planned'::appointments.appointment_status")
                .HasSentinel(AppointmentStatus.Planned)
                .IsRequired();
            b.Property(x => x.Reason)
                .HasColumnName("reason")
                .HasMaxLength(200);
            b.Property(x => x.Location)
                .HasColumnName("location")
                .HasMaxLength(200);
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_appointments_patients");

            b.HasOne<DoctorEntity>()
                .WithMany()
                .HasForeignKey(x => x.DoctorId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_appointments_doctors");
        });

        builder.Entity<VisitNoteEntity>(b =>
        {
            b.ToTable("visit_notes", "appointments");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.AppointmentId)
                .HasColumnName("appointment_id")
                .IsRequired();
            b.Property(x => x.NotesByDoctor)
                .HasColumnName("notes_by_doctor");
            b.Property(x => x.NotesByPatient)
                .HasColumnName("notes_by_patient");
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<AppointmentEntity>()
                .WithMany()
                .HasForeignKey(x => x.AppointmentId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_visit_notes_appointments");
        });

        builder.Entity<AiVisitBriefEntity>(b =>
        {
            b.ToTable("ai_visit_briefs", "appointments");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.AppointmentId)
                .HasColumnName("appointment_id")
                .IsRequired();
            b.Property(x => x.SummaryForDoctor)
                .HasColumnName("summary_for_doctor");
            b.Property(x => x.SummaryForPatient)
                .HasColumnName("summary_for_patient");
            b.Property(x => x.GeneratedAt)
                .HasColumnName("generated_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<AppointmentEntity>()
                .WithMany()
                .HasForeignKey(x => x.AppointmentId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_ai_visit_briefs_appointments");
        });
    }

    private static void ConfigureDevicesSchema(ModelBuilder builder)
    {
        builder.Entity<DeviceLinkEntity>(b =>
        {
            b.ToTable("device_links", "devices");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.Provider)
                .HasColumnName("provider")
                .HasMaxLength(80)
                .IsRequired();
            b.Property(x => x.ExternalId)
                .HasColumnName("external_id")
                .HasMaxLength(200)
                .IsRequired();
            b.Property(x => x.LinkedAt)
                .HasColumnName("linked_at")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.IsActive)
                .HasColumnName("is_active")
                .HasDefaultValue(true)
                .IsRequired();

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_device_links_patients");
        });

        builder.Entity<VitalReadingEntity>(b =>
        {
            b.ToTable("vital_readings", "devices");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.DeviceLinkId)
                .HasColumnName("device_link_id");
            b.Property(x => x.VitalType)
                .HasColumnName("vital_type")
                .HasColumnType("devices.vital_type")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.ValueNumeric)
                .HasColumnName("value_numeric")
                .HasColumnType("numeric(12,4)");
            b.Property(x => x.ValueText)
                .HasColumnName("value_text")
                .HasMaxLength(80);
            b.Property(x => x.Unit)
                .HasColumnName("unit")
                .HasMaxLength(20);
            b.Property(x => x.TakenAt)
                .HasColumnName("taken_at")
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_vital_readings_patients");

            b.HasOne<DeviceLinkEntity>()
                .WithMany()
                .HasForeignKey(x => x.DeviceLinkId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_vital_readings_device_links");

            b.HasIndex(x => new { x.PatientId, x.TakenAt })
                .HasDatabaseName("idx_vital_patient_time")
                .IsDescending(false, true);
        });
    }

    private static void ConfigureEngagementSchema(ModelBuilder builder)
    {
        builder.Entity<NotificationEntity>(b =>
        {
            b.ToTable("notifications", "engagement");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id");
            b.Property(x => x.UserId)
                .HasColumnName("user_id");
            b.Property(x => x.Channel)
                .HasColumnName("channel")
                .HasColumnType("engagement.channel_type")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.TemplateKey)
                .HasColumnName("template_key")
                .HasMaxLength(80);
            b.Property(x => x.PayloadJson)
                .HasColumnName("payload_json")
                .HasColumnType("jsonb")
                .IsRequired();
            b.Property(x => x.Status)
                .HasColumnName("status")
                .HasColumnType("engagement.notification_status")
                .HasConversion<string>()
                .HasDefaultValueSql("'Pending'::engagement.notification_status")
                .HasSentinel(EngagementNotificationStatus.Pending)
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.SentAt)
                .HasColumnName("sent_at");

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_notifications_patients");

            b.HasOne<IdentityUserEntity>()
                .WithMany()
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_notifications_users");
        });

        builder.Entity<ChatSessionEntity>(b =>
        {
            b.ToTable("chat_sessions", "engagement");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.PatientId)
                .HasColumnName("patient_id")
                .IsRequired();
            b.Property(x => x.StartedAt)
                .HasColumnName("started_at")
                .HasDefaultValueSql("NOW()");
            b.Property(x => x.IsActive)
                .HasColumnName("is_active")
                .HasDefaultValue(true)
                .IsRequired();

            b.HasOne<PatientEntity>()
                .WithMany()
                .HasForeignKey(x => x.PatientId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("FK_chat_sessions_patients");
        });

        builder.Entity<ChatMessageEntity>(b =>
        {
            b.ToTable("chat_messages", "engagement");
            b.HasKey(x => x.Id);

            b.Property(x => x.Id)
                .HasColumnName("id")
                .HasDefaultValueSql("gen_random_uuid()");
            b.Property(x => x.SessionId)
                .HasColumnName("session_id")
                .IsRequired();
            b.Property(x => x.Sender)
                .HasColumnName("sender")
                .HasColumnType("engagement.message_sender")
                .HasConversion<string>()
                .IsRequired();
            b.Property(x => x.Content)
                .HasColumnName("content")
                .IsRequired();
            b.Property(x => x.CreatedAt)
                .HasColumnName("created_at")
                .HasDefaultValueSql("NOW()");

            b.HasOne<ChatSessionEntity>()
                .WithMany()
                .HasForeignKey(x => x.SessionId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_chat_messages_sessions");
        });
    }

    private static void ApplyUtcDateTimeConverter(ModelBuilder builder)
    {
        var dateTimeConverter = new ValueConverter<DateTime, DateTime>(
            v => v.Kind == DateTimeKind.Utc ? v : v.ToUniversalTime(),
            v => DateTime.SpecifyKind(v, DateTimeKind.Utc));

        var nullableDateTimeConverter = new ValueConverter<DateTime?, DateTime?>(
            v => v.HasValue ? (v.Value.Kind == DateTimeKind.Utc ? v.Value : v.Value.ToUniversalTime()) : v,
            v => v.HasValue ? DateTime.SpecifyKind(v.Value, DateTimeKind.Utc) : v);

        foreach (var entityType in builder.Model.GetEntityTypes().Where(e => e.ClrType != null))
        {
            foreach (var property in entityType.GetProperties())
            {
                if (property.ClrType == typeof(DateTime))
                {
                    builder.Entity(entityType.ClrType).Property(property.Name).HasConversion(dateTimeConverter);
                }
                else if (property.ClrType == typeof(DateTime?))
                {
                    builder.Entity(entityType.ClrType).Property(property.Name).HasConversion(nullableDateTimeConverter);
                }
            }
        }
    }
}

public class IdentityUserEntity
{
    public Guid Id { get; set; }
    public string UserName { get; set; } = default!;
    public string Email { get; set; } = default!;
    public string PasswordHash { get; set; } = default!;
    public string UserType { get; set; } = default!;
    public string? PhotoStorageKey { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class PatientEntity
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string? Salutation { get; set; }
    public string FullName { get; set; } = default!;
    public DateOnly? DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public string? Country { get; set; }
    public string? MobileNumber { get; set; }
    public string? HealthVaultId { get; set; }
    public string? ResidenceCountry { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class DoctorEntity
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string? Salutation { get; set; }
    public string FullName { get; set; } = default!;
    public string? Gender { get; set; }
    public string? Specialty { get; set; }
    public string? RegistrationNo { get; set; }
    public string? ClinicName { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class FamilyLinkEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public Guid FamilyUserId { get; set; }
    public string Relationship { get; set; } = default!;
    public bool IsGuardian { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class PatientIdentifierEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public string IdType { get; set; } = default!;
    public string IdNumber { get; set; } = default!;
    public string? IssuerCountry { get; set; }
    public DateOnly? IssueDate { get; set; }
    public DateOnly? ExpiryDate { get; set; }
    public string? Notes { get; set; }
    public Guid? RecordId { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class PatientInsuranceEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public string InsurerName { get; set; } = default!;
    public string PolicyNumber { get; set; } = default!;
    public string? MemberId { get; set; }
    public string? PlanName { get; set; }
    public string? InsurerCountry { get; set; }
    public DateOnly? IssueDate { get; set; }
    public DateOnly? ExpiryDate { get; set; }
    public bool IsActive { get; set; }
    public Guid? RecordId { get; set; }
    public DateTime CreatedAt { get; set; }
}

public enum VaultRecordType
{
    Report,
    Prescription,
    Discharge,
    Imaging,
    NationalId,
    Insurance,
    Other
}

public enum VaultSensitivityLevel
{
    Public,
    Restricted,
    Confidential
}

public class VaultRecordEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public VaultRecordType RecordType { get; set; }
    public string Title { get; set; } = default!;
    public string? Description { get; set; }
    public string FileStorageKey { get; set; } = default!;
    public VaultSensitivityLevel Sensitivity { get; set; }
    public string? Source { get; set; }
    public DateTime CreatedAt { get; set; }
}

public enum VaultEventType
{
    RecordUploaded,
    Appointment,
    MedicationStarted,
    MedicationReminder,
    VitalReading,
    AiInsight
}

public class VaultTimelineEventEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public VaultEventType EventType { get; set; }
    public Guid? RelatedId { get; set; }
    public DateTime EventTime { get; set; }
    public string? Summary { get; set; }
    public string? DetailsJson { get; set; }
}

public enum ConsentActorType
{
    Doctor,
    Family
}

public class ConsentSessionEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public Guid ActorUserId { get; set; }
    public ConsentActorType ActorType { get; set; }
    public string ScopeJson { get; set; } = default!;
    public DateTime ExpiresAt { get; set; }
    public DateTime CreatedAt { get; set; }
    public bool IsRevoked { get; set; }
}

public class ConsentAccessLogEntity
{
    public Guid Id { get; set; }
    public Guid ConsentSessionId { get; set; }
    public DateTime AccessedAt { get; set; }
    public string? ResourceType { get; set; }
    public Guid? ResourceId { get; set; }
    public string? Action { get; set; }
}

public class PrescriptionEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public Guid? DoctorId { get; set; }
    public Guid? RecordId { get; set; }
    public DateOnly IssuedOn { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class MedicationItemEntity
{
    public Guid Id { get; set; }
    public Guid PrescriptionId { get; set; }
    public string Name { get; set; } = default!;
    public string? Dosage { get; set; }
    public string? Frequency { get; set; }
    public string? Route { get; set; }
    public int? DurationDays { get; set; }
    public string? Instructions { get; set; }
}

public class MedicationScheduleEntity
{
    public Guid Id { get; set; }
    public Guid MedicationItemId { get; set; }
    public DateOnly StartDate { get; set; }
    public DateOnly? EndDate { get; set; }
    public string TimesInDay { get; set; } = default!;
    public string Timezone { get; set; } = default!;
}

public enum MedicationDoseStatus
{
    Scheduled,
    Taken,
    Missed,
    Skipped
}

public class MedicationDoseEntity
{
    public Guid Id { get; set; }
    public Guid ScheduleId { get; set; }
    public DateTime DueAt { get; set; }
    public MedicationDoseStatus Status { get; set; }
    public DateTime? TakenAt { get; set; }
    public string? Notes { get; set; }
}

public enum AppointmentStatus
{
    Planned,
    Completed,
    Cancelled,
    NoShow
}

public class AppointmentEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public Guid DoctorId { get; set; }
    public DateTime ScheduledAt { get; set; }
    public AppointmentStatus Status { get; set; }
    public string? Reason { get; set; }
    public string? Location { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class VisitNoteEntity
{
    public Guid Id { get; set; }
    public Guid AppointmentId { get; set; }
    public string? NotesByDoctor { get; set; }
    public string? NotesByPatient { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class AiVisitBriefEntity
{
    public Guid Id { get; set; }
    public Guid AppointmentId { get; set; }
    public string? SummaryForDoctor { get; set; }
    public string? SummaryForPatient { get; set; }
    public DateTime GeneratedAt { get; set; }
}

public class DeviceLinkEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public string Provider { get; set; } = default!;
    public string ExternalId { get; set; } = default!;
    public DateTime LinkedAt { get; set; }
    public bool IsActive { get; set; }
}

public enum VitalType
{
    HeartRate,
    BloodPressure,
    Glucose,
    Steps,
    Weight,
    SpO2
}

public class VitalReadingEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public Guid? DeviceLinkId { get; set; }
    public VitalType VitalType { get; set; }
    public decimal? ValueNumeric { get; set; }
    public string? ValueText { get; set; }
    public string? Unit { get; set; }
    public DateTime TakenAt { get; set; }
    public DateTime CreatedAt { get; set; }
}

public enum EngagementChannelType
{
    Push,
    Email,
    Sms,
    WhatsApp
}

public enum EngagementNotificationStatus
{
    Pending,
    Sent,
    Failed
}

public class NotificationEntity
{
    public Guid Id { get; set; }
    public Guid? PatientId { get; set; }
    public Guid? UserId { get; set; }
    public EngagementChannelType Channel { get; set; }
    public string? TemplateKey { get; set; }
    public string PayloadJson { get; set; } = default!;
    public EngagementNotificationStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? SentAt { get; set; }
}

public class ChatSessionEntity
{
    public Guid Id { get; set; }
    public Guid PatientId { get; set; }
    public DateTime StartedAt { get; set; }
    public bool IsActive { get; set; }
}

public enum EngagementMessageSender
{
    Patient,
    AiAssistant
}

public class ChatMessageEntity
{
    public Guid Id { get; set; }
    public Guid SessionId { get; set; }
    public EngagementMessageSender Sender { get; set; }
    public string Content { get; set; } = default!;
    public DateTime CreatedAt { get; set; }
}
