using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Services;

namespace PatientService.PatientSummaries;

public interface IPatientSummaryAppService : IApplicationService
{
    Task<PatientSummaryDto?> GetAsync(Guid identityPatientId);
}
