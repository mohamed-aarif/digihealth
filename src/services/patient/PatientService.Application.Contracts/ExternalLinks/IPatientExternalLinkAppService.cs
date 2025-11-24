using System;
using Volo.Abp.Application.Services;

namespace PatientService.ExternalLinks;

public interface IPatientExternalLinkAppService :
    ICrudAppService<
        PatientExternalLinkDto,
        Guid,
        PatientExternalLinkGetListInput,
        CreateUpdatePatientExternalLinkDto>
{
}
