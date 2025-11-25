using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Services;

namespace PatientService;

public interface IPatientIdentityLookupAppService : IApplicationService
{
    Task<bool> ValidatePatientIdAsync(Guid identityPatientId);
}
