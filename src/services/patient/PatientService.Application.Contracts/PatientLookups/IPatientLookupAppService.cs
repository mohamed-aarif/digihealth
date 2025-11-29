using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Services;

namespace PatientService.PatientLookups;

public interface IPatientLookupAppService : IApplicationService
{
    Task<PatientLookupDto?> GetAsync(Guid identityPatientId);
}
