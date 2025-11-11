using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

[ConnectionStringName(IdentityServiceDbProperties.ConnectionStringName)]
public class IdentityServiceDbContext : AbpIdentityDbContext<IdentityServiceDbContext>, IIdentityServiceDbContext
{
    public DbSet<Patient> Patients { get; set; } = default!;
    public DbSet<Doctor> Doctors { get; set; } = default!;
    public DbSet<FamilyLink> FamilyLinks { get; set; } = default!;

    public IdentityServiceDbContext(DbContextOptions<IdentityServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.HasDefaultSchema(IdentityServiceDbProperties.DbSchema);
        builder.ConfigureIdentityService();
    }
}
