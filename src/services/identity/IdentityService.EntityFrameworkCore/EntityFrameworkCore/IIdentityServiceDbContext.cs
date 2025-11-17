using IdentityService.Doctors;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

public interface IIdentityServiceDbContext : IEfCoreDbContext, IIdentityDbContext
{
    DbSet<Patient> Patients { get; }
    DbSet<Doctor> Doctors { get; }
}
