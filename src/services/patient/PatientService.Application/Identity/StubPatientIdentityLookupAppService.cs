using System;
using System.Threading.Tasks;
using PatientService.Identity;
using Volo.Abp.Application.Services;

namespace PatientService.Identity;

public class StubPatientIdentityLookupAppService : ApplicationService, IPatientIdentityLookupAppService
{
    public Task<bool> ValidatePatientAsync(Guid identityPatientId)
    {
        // TODO: replace with HTTP/gRPC call to IdentityService
        return Task.FromResult(identityPatientId != Guid.Empty);
    }
}
