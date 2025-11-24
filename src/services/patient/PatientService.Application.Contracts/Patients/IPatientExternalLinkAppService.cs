using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.Patients;

public interface IPatientExternalLinkAppService :
    ICrudAppService<
        PatientExternalLinkDto,
        Guid,
        PatientExternalLinkPagedAndSortedResultRequestDto,
        CreateUpdatePatientExternalLinkDto>
{
}
