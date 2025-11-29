using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using IdentityService.Users;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.PermissionManagement;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;
using Volo.Abp.TenantManagement;
using Volo.Abp.TenantManagement.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

[ConnectionStringName(IdentityServiceDbProperties.ConnectionStringName)]

[ReplaceDbContext(
    typeof(IIdentityDbContext),
    typeof(ITenantManagementDbContext),
    typeof(IPermissionManagementDbContext)
)]
public class IdentityServiceDbContext
    : AbpDbContext<IdentityServiceDbContext>,
      IIdentityDbContext,
      ITenantManagementDbContext,
      IPermissionManagementDbContext
{
    public DbSet<IdentityUser> Users { get; set; } = default!;
    public DbSet<IdentityRole> Roles { get; set; } = default!;
    public DbSet<IdentityClaimType> ClaimTypes { get; set; } = default!;
    public DbSet<OrganizationUnit> OrganizationUnits { get; set; } = default!;
    public DbSet<OrganizationUnitRole> OrganizationUnitRoles { get; set; } = default!;
    public DbSet<IdentitySecurityLog> SecurityLogs { get; set; } = default!;
    public DbSet<IdentityUserDelegation> UserDelegations { get; set; } = default!;
    public DbSet<IdentityLinkUser> LinkUsers { get; set; } = default!;
    public DbSet<IdentitySession> Sessions { get; set; } = default!;

    public DbSet<Patient> Patients { get; set; } = default!;
    public DbSet<Doctor> Doctors { get; set; } = default!;
    public DbSet<FamilyLink> FamilyLinks { get; set; } = default!;
    public DbSet<UserProfile> UserProfiles { get; set; } = default!;

    public DbSet<PermissionGroupDefinitionRecord> PermissionGroups { get; set; } = default!;
    public DbSet<PermissionDefinitionRecord> Permissions { get; set; } = default!;
    public DbSet<PermissionGrant> PermissionGrants { get; set; } = default!;

    public DbSet<Tenant> Tenants { get; set; } = default!;

    public DbSet<TenantConnectionString> TenantConnectionStrings { get; set; } = default!;

    public IdentityServiceDbContext(DbContextOptions<IdentityServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        // All tables in this DbContext default to the "identity" schema
        builder.HasDefaultSchema(IdentityServiceDbProperties.DbSchema); // "identity"

        base.OnModelCreating(builder);

        // ABP module configs
        builder.ConfigureIdentity();
        builder.ConfigurePermissionManagement();
        builder.ConfigureTenantManagement();
        builder.ConfigureIdentityService();

        //
        // ?? Tenant Management – force ABP table names
        //
        builder.Entity<Tenant>(b =>
        {
            // Map to identity."AbpTenants"
            b.ToTable(
                "AbpTenants",
                IdentityServiceDbProperties.DbSchema
            );
        });

        builder.Entity<TenantConnectionString>(b =>
        {
            // Map to identity."AbpTenantConnectionStrings"
            b.ToTable(
                "AbpTenantConnectionStrings",
                IdentityServiceDbProperties.DbSchema
            );

            // Composite PK required by EF
            b.HasKey(x => new { x.TenantId, x.Name });
        });
    }
}
