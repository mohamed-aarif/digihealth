using System;
using System.Threading.Tasks;
using IdentityService.Patients;
using PatientService.Permissions;
using Volo.Abp.Application.Services;
using Volo.Abp.Authorization;
using Volo.Abp.Http.Client;

namespace PatientService;

[Authorize(PatientServicePermissions.PatientLookups.Default)]
public class PatientIdentityLookupAppService : ApplicationService, IPatientIdentityLookupAppService
{
    private readonly IPatientAppService _patientAppService;

    public PatientIdentityLookupAppService(IPatientAppService patientAppService)
    {
        _patientAppService = patientAppService;
    }

    public async Task<bool> ValidatePatientIdAsync(Guid identityPatientId)
    {
        if (identityPatientId == Guid.Empty)
        {
            return false;
        }

        try
        {
            _ = await _patientAppService.GetAsync(identityPatientId);
            return true;
        }
        catch (AbpRemoteCallException)
        {
            return false;
        }
    }
}
