using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DigiHealth.ConfigurationService.Permissions;
using IdentityService.Doctors;
using IdentityService.Patients;
using IdentityService.Users;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Identity;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Guids;
using Volo.Abp.Identity;
using Volo.Abp.MultiTenancy;
using Volo.Abp.PermissionManagement;
using Volo.Abp.Authorization.Permissions;
using IdentityPermissions = Volo.Abp.Identity.IdentityPermissions;

namespace IdentityService.Data;

public class IdentityServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IGuidGenerator _guidGenerator;
    private readonly IdentityUserManager _userManager;
    private readonly IdentityRoleManager _roleManager;
    private readonly IRepository<Doctor, Guid> _doctorRepository;
    private readonly IRepository<Patient, Guid> _patientRepository;
    private readonly IRepository<UserProfile, Guid> _userProfileRepository;
    private readonly ICurrentTenant _currentTenant;
    private readonly IPermissionDataSeeder _permissionDataSeeder;
    private readonly ILogger<IdentityServiceDataSeedContributor> _logger;

    private const string AdminRoleName = "admin";

    public IdentityServiceDataSeedContributor(
        IGuidGenerator guidGenerator,
        IdentityUserManager userManager,
        IdentityRoleManager roleManager,
        IRepository<Doctor, Guid> doctorRepository,
        IRepository<Patient, Guid> patientRepository,
        IRepository<UserProfile, Guid> userProfileRepository,
        ICurrentTenant currentTenant,
        IPermissionDataSeeder permissionDataSeeder,
        ILogger<IdentityServiceDataSeedContributor> logger)
    {
        _guidGenerator = guidGenerator;
        _userManager = userManager;
        _roleManager = roleManager;
        _doctorRepository = doctorRepository;
        _patientRepository = patientRepository;
        _userProfileRepository = userProfileRepository;
        _currentTenant = currentTenant;
        _permissionDataSeeder = permissionDataSeeder;
        _logger = logger;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        // IdentityService should only seed host-level sample data. Skip tenant-specific seeding
        // to avoid touching tenant management tables when they are not available.
        if (context.TenantId.HasValue)
        {
            return;
        }

        try
        {
            var adminRole = await EnsureHostAdminRoleAsync();
            var adminUser = await EnsureHostAdminAsync();
            await AddUserToRoleAsync(adminUser, adminRole.Name);
            await SeedAdminPermissionsAsync(adminRole, context.TenantId);
            await EnsureHostDoctorAsync();
            await EnsureHostPatientAsync();
        }
        catch (BusinessException ex)
        {
            _logger.LogWarning(ex, "Skipping identity seed because tenant prerequisites are not available.");
        }
    }

    private async Task<IdentityRole> EnsureHostAdminRoleAsync()
    {
        using (_currentTenant.Change(null))
        {
            var adminRole = await _roleManager.FindByNameAsync(AdminRoleName);
            if (adminRole == null)
            {
                adminRole = new IdentityRole(_guidGenerator.Create(), AdminRoleName, null)
                {
                    IsStatic = true
                };

                CheckErrors(await _roleManager.CreateAsync(adminRole));
            }

            return adminRole;
        }
    }

    private async Task<IdentityUser> EnsureHostAdminAsync()
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
            return user;
        }
    }

    private async Task AddUserToRoleAsync(IdentityUser user, string roleName)
    {
        if (!await _userManager.IsInRoleAsync(user, roleName))
        {
            CheckErrors(await _userManager.AddToRoleAsync(user, roleName));
        }
    }

    private async Task SeedAdminPermissionsAsync(IdentityRole adminRole, Guid? tenantId)
    {
        var permissions = new List<string>
        {
            IdentityPermissions.Roles.Default,
            IdentityPermissions.Roles.Create,
            IdentityPermissions.Roles.Update,
            IdentityPermissions.Roles.Delete,
            IdentityPermissions.Roles.ManagePermissions,
            IdentityPermissions.Users.Default,
            IdentityPermissions.Users.Create,
            IdentityPermissions.Users.Update,
            IdentityPermissions.Users.Delete,
            IdentityPermissions.Users.ManagePermissions
        };

        permissions.AddRange(new[]
        {
            ConfigurationPermissions.AppointmentChannels.Default,
            ConfigurationPermissions.AppointmentChannels.Manage,
            ConfigurationPermissions.AppointmentChannels.Create,
            ConfigurationPermissions.AppointmentChannels.Edit,
            ConfigurationPermissions.AppointmentChannels.Delete,
            ConfigurationPermissions.AppointmentStatuses.Default,
            ConfigurationPermissions.AppointmentStatuses.Manage,
            ConfigurationPermissions.AppointmentStatuses.Create,
            ConfigurationPermissions.AppointmentStatuses.Edit,
            ConfigurationPermissions.AppointmentStatuses.Delete,
            ConfigurationPermissions.ConsentPartyTypes.Default,
            ConfigurationPermissions.ConsentPartyTypes.Manage,
            ConfigurationPermissions.ConsentPartyTypes.Create,
            ConfigurationPermissions.ConsentPartyTypes.Edit,
            ConfigurationPermissions.ConsentPartyTypes.Delete,
            ConfigurationPermissions.ConsentStatuses.Default,
            ConfigurationPermissions.ConsentStatuses.Manage,
            ConfigurationPermissions.ConsentStatuses.Create,
            ConfigurationPermissions.ConsentStatuses.Edit,
            ConfigurationPermissions.ConsentStatuses.Delete,
            ConfigurationPermissions.DaysOfWeek.Default,
            ConfigurationPermissions.DaysOfWeek.Manage,
            ConfigurationPermissions.DaysOfWeek.Create,
            ConfigurationPermissions.DaysOfWeek.Edit,
            ConfigurationPermissions.DaysOfWeek.Delete,
            ConfigurationPermissions.DeviceReadingTypes.Default,
            ConfigurationPermissions.DeviceReadingTypes.Manage,
            ConfigurationPermissions.DeviceReadingTypes.Create,
            ConfigurationPermissions.DeviceReadingTypes.Edit,
            ConfigurationPermissions.DeviceReadingTypes.Delete,
            ConfigurationPermissions.DeviceTypes.Default,
            ConfigurationPermissions.DeviceTypes.Manage,
            ConfigurationPermissions.DeviceTypes.Create,
            ConfigurationPermissions.DeviceTypes.Edit,
            ConfigurationPermissions.DeviceTypes.Delete,
            ConfigurationPermissions.MedicationIntakeStatuses.Default,
            ConfigurationPermissions.MedicationIntakeStatuses.Manage,
            ConfigurationPermissions.MedicationIntakeStatuses.Create,
            ConfigurationPermissions.MedicationIntakeStatuses.Edit,
            ConfigurationPermissions.MedicationIntakeStatuses.Delete,
            ConfigurationPermissions.NotificationChannels.Default,
            ConfigurationPermissions.NotificationChannels.Manage,
            ConfigurationPermissions.NotificationChannels.Create,
            ConfigurationPermissions.NotificationChannels.Edit,
            ConfigurationPermissions.NotificationChannels.Delete,
            ConfigurationPermissions.NotificationStatuses.Default,
            ConfigurationPermissions.NotificationStatuses.Manage,
            ConfigurationPermissions.NotificationStatuses.Create,
            ConfigurationPermissions.NotificationStatuses.Edit,
            ConfigurationPermissions.NotificationStatuses.Delete,
            ConfigurationPermissions.RelationshipTypes.Default,
            ConfigurationPermissions.RelationshipTypes.Manage,
            ConfigurationPermissions.RelationshipTypes.Create,
            ConfigurationPermissions.RelationshipTypes.Edit,
            ConfigurationPermissions.RelationshipTypes.Delete,
            ConfigurationPermissions.VaultRecordTypes.Default,
            ConfigurationPermissions.VaultRecordTypes.Manage,
            ConfigurationPermissions.VaultRecordTypes.Create,
            ConfigurationPermissions.VaultRecordTypes.Edit,
            ConfigurationPermissions.VaultRecordTypes.Delete
        });

        await _permissionDataSeeder.SeedAsync(
            RolePermissionValueProvider.ProviderName,
            adminRole.Name,
            permissions.Distinct().ToArray(),
            tenantId);
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

    private static void CheckErrors(IdentityResult identityResult)
    {
        if (!identityResult.Succeeded)
        {
            var errors = string.Join("; ", identityResult.Errors.Select(e => $"{e.Code}: {e.Description}"));
            throw new BusinessException("IdentityOperationFailed").WithData("Errors", errors);
        }
    }
}
