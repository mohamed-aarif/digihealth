using System;
using IdentityService.PatientInsurances.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.PatientInsurances;

public interface IPatientInsuranceAppService :
    ICrudAppService<PatientInsuranceDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientInsuranceDto>
{
}
