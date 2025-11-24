using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Services;

namespace PatientService.Patients;

public interface IPatientIdentityLookupAppService : IApplicationService
{
    Task<bool> IdentityPatientExistsAsync(Guid identityPatientId);
}
