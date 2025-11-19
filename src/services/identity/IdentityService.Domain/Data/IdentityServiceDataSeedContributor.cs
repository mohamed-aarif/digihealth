using System;
using System.Threading.Tasks;
using IdentityService.Doctors;
using IdentityService.Patients;
using IdentityService.Users;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Guids;
using Volo.Abp.Identity;
using Volo.Abp.MultiTenancy;
using Volo.Abp.TenantManagement;

namespace IdentityService.Data;

public class IdentityServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly ITenantRepository _tenantRepository;
    private readonly IGuidGenerator _guidGenerator;
    private readonly TenantManager _tenantManager;
    private readonly IdentityUserManager _userManager;
    private readonly IRepository<Doctor, Guid> _doctorRepository;
    private readonly IRepository<Patient, Guid> _patientRepository;
    private readonly ICurrentTenant _currentTenant;

    public IdentityServiceDataSeedContributor(
        ITenantRepository tenantRepository,
        IGuidGenerator guidGenerator,
        TenantManager tenantManager,
        IdentityUserManager userManager,
        IRepository<Doctor, Guid> doctorRepository,
        IRepository<Patient, Guid> patientRepository,
        ICurrentTenant currentTenant)
    {
        _tenantRepository = tenantRepository;
        _guidGenerator = guidGenerator;
        _tenantManager = tenantManager;
        _userManager = userManager;
        _doctorRepository = doctorRepository;
        _patientRepository = patientRepository;
        _currentTenant = currentTenant;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var defaultTenant = await EnsureTenantAsync("Default Clinic");

        await EnsureHostAdminAsync();
        await EnsureTenantAdminAsync(defaultTenant);
        await EnsureSamplePatientAsync(defaultTenant);
    }

    private async Task<Tenant> EnsureTenantAsync(string name)
    {
        var tenant = await _tenantRepository.FindByNameAsync(name);
        if (tenant != null)
        {
            return tenant;
        }

        tenant = await _tenantManager.CreateAsync(name);
        return await _tenantRepository.InsertAsync(tenant);
    }

    private async Task EnsureHostAdminAsync()
    {
        using (_currentTenant.Change(null))
        {
            var user = await _userManager.FindByEmailAsync("host.admin@digihealth.local");
            if (user == null)
            {
                user = new IdentityUser(_guidGenerator.Create(), "hostadmin", "host.admin@digihealth.local", null)
                {
                    Name = "Host",
                    Surname = "Admin"
                };
                user.SetSalutation("Mr");
                await _userManager.CreateAsync(user, "HostAdmin123!");
            }
        }
    }

    private async Task EnsureTenantAdminAsync(Tenant tenant)
    {
        using (_currentTenant.Change(tenant.Id))
        {
            var user = await _userManager.FindByEmailAsync("admin@defaultclinic.local");
            if (user == null)
            {
                user = new IdentityUser(_guidGenerator.Create(), "clinicadmin", "admin@defaultclinic.local", tenant.Id)
                {
                    Name = "Default",
                    Surname = "Admin"
                };
                user.SetSalutation("Dr");
                await _userManager.CreateAsync(user, "ClinicAdmin123!");
            }

            if (!await _doctorRepository.AnyAsync(x => x.UserId == user.Id))
            {
                await _doctorRepository.InsertAsync(
                    new Doctor(
                        _guidGenerator.Create(),
                        user.Id,
                        tenant.Id,
                        user.GetSalutation(),
                        "Male",
                        "General Medicine",
                        "REG-001"),
                    autoSave: true);
            }
        }
    }

    private async Task EnsureSamplePatientAsync(Tenant tenant)
    {
        using (_currentTenant.Change(tenant.Id))
        {
            var user = await _userManager.FindByEmailAsync("patient1@defaultclinic.local");
            if (user == null)
            {
                user = new IdentityUser(_guidGenerator.Create(), "patient1", "patient1@defaultclinic.local", tenant.Id)
                {
                    Name = "Sample",
                    Surname = "Patient"
                };
                user.SetSalutation("Ms");
                await _userManager.CreateAsync(user, "Patient123!");
            }

            if (!await _patientRepository.AnyAsync(x => x.UserId == user.Id))
            {
                await _patientRepository.InsertAsync(
                    new Patient(
                        _guidGenerator.Create(),
                        user.Id,
                        tenant.Id,
                        user.GetSalutation(),
                        DateTime.UtcNow.AddYears(-30).Date,
                        "Female",
                        "UAE"),
                    autoSave: true);
            }
        }
    }
}
