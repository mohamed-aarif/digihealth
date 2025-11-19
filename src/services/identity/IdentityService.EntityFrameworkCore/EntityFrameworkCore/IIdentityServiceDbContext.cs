using IdentityService.Doctors;
using IdentityService.Patients;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

public interface IIdentityServiceDbContext : IEfCoreDbContext, IIdentityDbContext, IPermissionManagementDbContext
{
    DbSet<Patient> Patients { get; }
    DbSet<Doctor> Doctors { get; }
}
