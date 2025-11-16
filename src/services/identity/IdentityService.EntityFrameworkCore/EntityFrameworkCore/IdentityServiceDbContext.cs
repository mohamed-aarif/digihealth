using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.PatientIdentifiers;
using IdentityService.PatientInsurances;
using IdentityService.Patients;
using IdentityService.Users;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

[ConnectionStringName(IdentityServiceDbProperties.ConnectionStringName)]
public class IdentityServiceDbContext : AbpDbContext<IdentityServiceDbContext>, IIdentityServiceDbContext
{
    public DbSet<IdentityUserAccount> IdentityUsers { get; set; } = default!;
    public DbSet<Patient> Patients { get; set; } = default!;
    public DbSet<Doctor> Doctors { get; set; } = default!;
    public DbSet<FamilyLink> FamilyLinks { get; set; } = default!;
    public DbSet<PatientIdentifier> PatientIdentifiers { get; set; } = default!;
    public DbSet<PatientInsurance> PatientInsurances { get; set; } = default!;

    public IdentityServiceDbContext(DbContextOptions<IdentityServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.HasDefaultSchema(IdentityServiceDbProperties.DbSchema);

        base.OnModelCreating(builder);

        builder.ConfigureIdentityService();
    }
}
