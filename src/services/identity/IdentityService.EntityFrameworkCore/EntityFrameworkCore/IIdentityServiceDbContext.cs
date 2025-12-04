using IdentityService.DoctorPatientLinks;
using IdentityService.Doctors;
using IdentityService.FamilyLinks;
using IdentityService.HealthPassports;
using IdentityService.Patients;
using IdentityService.SubscriptionPlans;
using IdentityService.UserSubscriptions;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Identity.EntityFrameworkCore;
using Volo.Abp.PermissionManagement.EntityFrameworkCore;

namespace IdentityService.EntityFrameworkCore;

public interface IIdentityServiceDbContext : IEfCoreDbContext, IIdentityDbContext, IPermissionManagementDbContext
{
    DbSet<Patient> Patients { get; }
    DbSet<Doctor> Doctors { get; }
    DbSet<FamilyLink> FamilyLinks { get; }
    DbSet<DoctorPatientLink> DoctorPatientLinks { get; }
    DbSet<HealthPassport> HealthPassports { get; }
    DbSet<SubscriptionPlan> SubscriptionPlans { get; }
    DbSet<UserSubscription> UserSubscriptions { get; }
}
