using System;
using System.Threading.Tasks;
using IdentityService.Doctors;
using IdentityService.Patients;
using IdentityService.Permissions;
using IdentityService.Profiles.Dtos;
using IdentityService.Users;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Identity;
using Volo.Abp.MultiTenancy;

namespace IdentityService.Profiles;

[Authorize(IdentityServicePermissions.Profile.Default)]
public class ProfileAppService : IdentityServiceAppService, IProfileAppService
{
    private readonly IdentityUserManager _identityUserManager;
    private readonly IRepository<Doctor, Guid> _doctorRepository;
    private readonly IRepository<Patient, Guid> _patientRepository;
    private readonly ICurrentTenant _currentTenant;

    public ProfileAppService(
        IdentityUserManager identityUserManager,
        IRepository<Doctor, Guid> doctorRepository,
        IRepository<Patient, Guid> patientRepository,
        ICurrentTenant currentTenant)
    {
        _identityUserManager = identityUserManager;
        _doctorRepository = doctorRepository;
        _patientRepository = patientRepository;
        _currentTenant = currentTenant;
    }

    public async Task<ProfileDto> GetAsync()
    {
        var user = await GetCurrentUserAsync();
        return await BuildProfileAsync(user);
    }

    public async Task<ProfileDto> UpdateAsync(UpdateProfileDto input)
    {
        var user = await GetCurrentUserAsync();

        if (!input.Name.IsNullOrWhiteSpace())
        {
            user.Name = input.Name;
        }

        if (!input.Surname.IsNullOrWhiteSpace())
        {
            user.Surname = input.Surname;
        }

        user.SetSalutation(input.Salutation);
        user.SetProfilePhotoUrl(input.ProfilePhotoUrl);

        await _identityUserManager.UpdateAsync(user);

        return await BuildProfileAsync(user);
    }

    private async Task<IdentityUser> GetCurrentUserAsync()
    {
        var userId = CurrentUser.Id ?? throw new AbpException("Current user id is not available");
        var user = await _identityUserManager.GetByIdAsync(userId);
        return user;
    }

    private async Task<ProfileDto> BuildProfileAsync(IdentityUser user)
    {
        using (_currentTenant.Change(user.TenantId))
        {
            var profile = new ProfileDto
            {
                UserId = user.Id,
                TenantId = user.TenantId,
                UserName = user.UserName,
                Email = user.Email,
                Name = user.Name,
                Surname = user.Surname,
                PhoneNumber = user.PhoneNumber,
                Salutation = user.GetSalutation(),
                ProfilePhotoUrl = user.GetProfilePhotoUrl()
            };

            var doctor = await _doctorRepository.FirstOrDefaultAsync(x => x.UserId == user.Id);
            if (doctor != null)
            {
                profile.DoctorProfile = new DoctorProfileSnippetDto
                {
                    DoctorId = doctor.Id,
                    Specialization = doctor.Specialization,
                    RegistrationNumber = doctor.RegistrationNumber
                };
            }

            var patient = await _patientRepository.FirstOrDefaultAsync(x => x.UserId == user.Id);
            if (patient != null)
            {
                profile.PatientProfile = new PatientProfileSnippetDto
                {
                    PatientId = patient.Id,
                    DateOfBirth = patient.DateOfBirth,
                    ResidenceCountry = patient.ResidenceCountry
                };
            }

            return profile;
        }
    }
}
