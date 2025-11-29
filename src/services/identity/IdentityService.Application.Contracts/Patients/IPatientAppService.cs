using System;
using IdentityService.Patients.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.Patients;

public interface IPatientAppService :
    ICrudAppService<
        PatientDto,
        Guid,
        PatientPagedAndSortedResultRequestDto,
        CreatePatientDto,
        UpdatePatientDto>
{
}
