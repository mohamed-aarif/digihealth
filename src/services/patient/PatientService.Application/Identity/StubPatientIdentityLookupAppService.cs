using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using PatientService.Identity;
using Volo.Abp.DependencyInjection;

namespace PatientService.Identity;

public class StubPatientIdentityLookupAppService : IPatientIdentityLookupAppService, ITransientDependency
{
    private readonly ILogger<StubPatientIdentityLookupAppService> _logger;

    public StubPatientIdentityLookupAppService(ILogger<StubPatientIdentityLookupAppService> logger)
    {
        _logger = logger;
    }

    public Task<bool> ExistsAsync(Guid identityPatientId)
    {
        _logger.LogDebug("Stub identity lookup invoked for IdentityPatientId {IdentityPatientId}", identityPatientId);
        return Task.FromResult(true);
    }
}
