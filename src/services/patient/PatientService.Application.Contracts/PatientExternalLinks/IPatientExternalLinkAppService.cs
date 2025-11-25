using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.PatientExternalLinks;

public interface IPatientExternalLinkAppService :
    ICrudAppService<
        PatientExternalLinkDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientExternalLinkDto,
        CreateUpdatePatientExternalLinkDto>
{
    Task<PagedResultDto<PatientExternalLinkDto>> GetBySystemAsync(string systemName, Guid? identityPatientId);
}
