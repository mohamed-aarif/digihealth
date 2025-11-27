using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using IdentityService.FamilyLinks;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Patients;
using IdentityService.Patients.Dtos;
using IdentityService.Users;
using IdentityService.Users.Dtos;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Authorization;
using Volo.Abp.Http.Client;

namespace PatientService.PatientLookups;

[Authorize(PatientServicePermissions.PatientLookups.Default)]
public class PatientLookupAppService : ApplicationService, IPatientLookupAppService
{
    private readonly IPatientAppService _patientAppService;
    private readonly IUserProfileAppService _userProfileAppService;
    private readonly IFamilyLinkAppService _familyLinkAppService;

    public PatientLookupAppService(
        IPatientAppService patientAppService,
        IUserProfileAppService userProfileAppService,
        IFamilyLinkAppService familyLinkAppService)
    {
        _patientAppService = patientAppService;
        _userProfileAppService = userProfileAppService;
        _familyLinkAppService = familyLinkAppService;
    }

    public async Task<PatientLookupDto?> GetAsync(Guid identityPatientId)
    {
        var patient = await GetPatientAsync(identityPatientId);
        if (patient == null)
        {
            return null;
        }

        var userProfile = await GetUserProfileAsync(patient.UserId);
        var familyLinks = await GetFamilyLinksAsync(identityPatientId);

        return new PatientLookupDto
        {
            Id = patient.Id,
            Patient = patient,
            UserProfile = userProfile,
            FamilyLinks = familyLinks
        };
    }

    private async Task<PatientDto?> GetPatientAsync(Guid identityPatientId)
    {
        try
        {
            return await _patientAppService.GetAsync(identityPatientId);
        }
        catch (Exception ex) when (IsNotFound(ex))
        {
            return null;
        }
    }

    private async Task<UserProfileDto?> GetUserProfileAsync(Guid userId)
    {
        try
        {
            return await _userProfileAppService.GetAsync(userId);
        }
        catch (Exception ex) when (IsNotFound(ex))
        {
            return null;
        }
    }

    private async Task<FamilyLinkDto[]> GetFamilyLinksAsync(Guid identityPatientId)
    {
        var list = await _familyLinkAppService.GetListAsync(
            new PagedAndSortedResultRequestDto { MaxResultCount = LimitedResultRequestDto.DefaultMaxResultCount });

        return list.Items.Where(x => x.PatientId == identityPatientId).ToArray();
    }

    private static bool IsNotFound(Exception exception)
    {
        return exception is EntityNotFoundException
               || (exception is AbpRemoteCallException remote && remote.HttpStatusCode == HttpStatusCode.NotFound);
    }
}
