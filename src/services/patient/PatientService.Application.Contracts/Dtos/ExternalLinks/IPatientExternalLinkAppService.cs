using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.Dtos.ExternalLinks;

public interface IPatientExternalLinkAppService :
    ICrudAppService<
        PatientExternalLinkDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientExternalLinkDto>
{
    Task<PagedResultDto<PatientExternalLinkDto>> GetListAsync(Guid identityPatientId, string? systemName);
}
