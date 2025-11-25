using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.PatientMedicalSummaries;

public interface IPatientMedicalSummaryAppService :
    ICrudAppService<
        PatientMedicalSummaryDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientMedicalSummaryDto,
        CreateUpdatePatientMedicalSummaryDto>
{
    Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId);
}
