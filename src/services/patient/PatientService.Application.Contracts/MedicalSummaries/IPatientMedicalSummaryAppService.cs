using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.MedicalSummaries;

public interface IPatientMedicalSummaryAppService :
    ICrudAppService<
        PatientMedicalSummaryDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientMedicalSummaryDto>
{
    Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId);
}
