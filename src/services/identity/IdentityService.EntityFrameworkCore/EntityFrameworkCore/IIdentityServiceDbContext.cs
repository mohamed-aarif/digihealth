using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.Patients;
using IdentityService.Users;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

public interface IIdentityServiceDbContext : IEfCoreDbContext
{
    DbSet<IdentityUserAccount> IdentityUsers { get; }
    DbSet<Patient> Patients { get; }
    DbSet<Doctor> Doctors { get; }
    DbSet<FamilyLink> FamilyLinks { get; }
}
