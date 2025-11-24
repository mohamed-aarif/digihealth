using Microsoft.EntityFrameworkCore;
using PatientService.Entities;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;

namespace PatientService.EntityFrameworkCore;

[ConnectionStringName(PatientServiceDbProperties.ConnectionStringName)]
public class PatientServiceDbContext : AbpDbContext<PatientServiceDbContext>
{
    public DbSet<PatientProfileExtension> PatientProfiles { get; set; } = default!;
    public DbSet<PatientMedicalSummary> PatientMedicalSummaries { get; set; } = default!;
    public DbSet<PatientExternalLink> PatientExternalLinks { get; set; } = default!;

    public PatientServiceDbContext(DbContextOptions<PatientServiceDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.HasDefaultSchema(PatientServiceDbProperties.DbSchema);

        base.OnModelCreating(builder);

        builder.ConfigurePatientService();
    }
}
