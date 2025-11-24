using System;
using System.Threading.Tasks;

namespace PatientService.Identity;

public interface IPatientIdentityLookupAppService
{
    Task<bool> ValidatePatientAsync(Guid identityPatientId);
}
