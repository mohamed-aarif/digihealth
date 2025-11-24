using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.Dtos.Profiles;

public interface IPatientProfileAppService :
    ICrudAppService<
        PatientProfileExtensionDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientProfileExtensionDto>
{
    Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId);
}
