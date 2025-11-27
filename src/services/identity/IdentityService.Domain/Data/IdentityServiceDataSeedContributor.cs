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

namespace IdentityService.Data;

public class IdentityServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IGuidGenerator _guidGenerator;
    private readonly IdentityUserManager _userManager;
    private readonly IRepository<Doctor, Guid> _doctorRepository;
    private readonly IRepository<Patient, Guid> _patientRepository;
    private readonly IRepository<UserProfile, Guid> _userProfileRepository;
    private readonly ICurrentTenant _currentTenant;

    public IdentityServiceDataSeedContributor(
        IGuidGenerator guidGenerator,
        IdentityUserManager userManager,
        IRepository<Doctor, Guid> doctorRepository,
        IRepository<Patient, Guid> patientRepository,
        IRepository<UserProfile, Guid> userProfileRepository,
        ICurrentTenant currentTenant)
    {
        _guidGenerator = guidGenerator;
        _userManager = userManager;
        _doctorRepository = doctorRepository;
        _patientRepository = patientRepository;
        _userProfileRepository = userProfileRepository;
        _currentTenant = currentTenant;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        await EnsureHostAdminAsync();
        await EnsureHostDoctorAsync();
        await EnsureHostPatientAsync();
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

            await EnsureUserProfileAsync(user);
        }
    }

    private async Task EnsureHostDoctorAsync()
    {
        using (_currentTenant.Change(null))
        {
            var user = await _userManager.FindByEmailAsync("host.doctor@digihealth.local");
            if (user == null)
            {
                user = new IdentityUser(_guidGenerator.Create(), "hostdoctor", "host.doctor@digihealth.local", null)
                {
                    Name = "Host",
                    Surname = "Doctor"
                };
                user.SetSalutation("Dr");
                await _userManager.CreateAsync(user, "HostDoctor123!");
            }

            await EnsureUserProfileAsync(user);

            if (!await _doctorRepository.AnyAsync(x => x.UserId == user.Id))
            {
                await _doctorRepository.InsertAsync(
                    new Doctor(
                        _guidGenerator.Create(),
                        user.Id,
                        null,
                        user.GetSalutation(),
                        "Male",
                        "General Medicine",
                        "REG-001"),
                    autoSave: true);
            }
        }
    }

    private async Task EnsureHostPatientAsync()
    {
        using (_currentTenant.Change(null))
        {
            var user = await _userManager.FindByEmailAsync("patient1@digihealth.local");
            if (user == null)
            {
                user = new IdentityUser(_guidGenerator.Create(), "patient1", "patient1@digihealth.local", null)
                {
                    Name = "Sample",
                    Surname = "Patient"
                };
                user.SetSalutation("Ms");
                await _userManager.CreateAsync(user, "Patient123!");
            }

            await EnsureUserProfileAsync(user);

            if (!await _patientRepository.AnyAsync(x => x.UserId == user.Id))
            {
                await _patientRepository.InsertAsync(
                    new Patient(
                        _guidGenerator.Create(),
                        user.Id,
                        null,
                        user.GetSalutation(),
                        DateTime.UtcNow.AddYears(-30).Date,
                        "Female",
                        "UAE"),
                    autoSave: true);
            }
        }
    }

    private async Task EnsureUserProfileAsync(IdentityUser user)
    {
        if (await _userProfileRepository.AnyAsync(x => x.Id == user.Id))
        {
            return;
        }

        var profile = new UserProfile(
            user.Id,
            user.TenantId,
            user.UserName,
            user.Email,
            user.GetSalutation(),
            user.GetProfilePhotoUrl(),
            user.Name,
            user.Surname,
            user.IsActive);

        await _userProfileRepository.InsertAsync(profile, autoSave: true);
    }
}
