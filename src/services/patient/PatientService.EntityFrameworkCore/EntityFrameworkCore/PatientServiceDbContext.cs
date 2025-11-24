using PatientService.ExternalLinks;
using PatientService.MedicalSummaries;
using PatientService.PatientProfiles;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.EntityFrameworkCore;

namespace PatientService.EntityFrameworkCore;

[ConnectionStringName(PatientServiceDbProperties.ConnectionStringName)]
[ExposeServices(typeof(PatientServiceDbContext))]
public class PatientServiceDbContext : AbpDbContext<PatientServiceDbContext>
{
    public DbSet<PatientProfileExtension> PatientProfiles { get; set; } = default!;
    public DbSet<PatientMedicalSummary> MedicalSummaries { get; set; } = default!;
    public DbSet<PatientExternalLink> ExternalLinks { get; set; } = default!;

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
