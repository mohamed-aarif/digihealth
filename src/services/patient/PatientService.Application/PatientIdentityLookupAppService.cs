using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Services;

namespace PatientService;

public class PatientIdentityLookupAppService : ApplicationService, IPatientIdentityLookupAppService
{
    public Task<bool> ValidatePatientIdAsync(Guid identityPatientId)
    {
        // TODO: Integrate with IdentityService via HTTP client or distributed events.
        return Task.FromResult(identityPatientId != Guid.Empty);
    }
}
