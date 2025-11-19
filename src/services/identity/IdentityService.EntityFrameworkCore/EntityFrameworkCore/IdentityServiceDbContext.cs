using IdentityService.Doctors;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.PermissionManagement;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

[ConnectionStringName(IdentityServiceDbProperties.ConnectionStringName)]
public class IdentityServiceDbContext : AbpDbContext<IdentityServiceDbContext>, IIdentityServiceDbContext
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

    public DbSet<PermissionGroupDefinitionRecord> PermissionGroups { get; set; } = default!;
    public DbSet<PermissionDefinitionRecord> Permissions { get; set; } = default!;
    public DbSet<PermissionGrant> PermissionGrants { get; set; } = default!;

    public IdentityServiceDbContext(DbContextOptions<IdentityServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.HasDefaultSchema(IdentityServiceDbProperties.DbSchema);

        base.OnModelCreating(builder);

        builder.ConfigureIdentity();
        builder.ConfigurePermissionManagement();
        builder.ConfigureIdentityService();
    }
}
