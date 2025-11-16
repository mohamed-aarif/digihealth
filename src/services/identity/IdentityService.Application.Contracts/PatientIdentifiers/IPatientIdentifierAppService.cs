using System;
using IdentityService.PatientIdentifiers.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.PatientIdentifiers;

public interface IPatientIdentifierAppService :
    ICrudAppService<PatientIdentifierDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientIdentifierDto>
{
}
