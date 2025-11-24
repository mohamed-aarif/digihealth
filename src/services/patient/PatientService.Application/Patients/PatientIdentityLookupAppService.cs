using System;
using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace PatientService.Patients;

public class PatientIdentityLookupAppService : IPatientIdentityLookupAppService, ITransientDependency
{
    public Task<bool> IdentityPatientExistsAsync(Guid identityPatientId)
    {
        // TODO: Replace with HTTP client call to IdentityService
        return Task.FromResult(true);
    }
}
