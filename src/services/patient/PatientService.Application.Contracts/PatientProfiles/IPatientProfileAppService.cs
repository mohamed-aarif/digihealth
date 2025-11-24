using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.PatientProfiles;

public interface IPatientProfileAppService :
    ICrudAppService<
        PatientProfileExtensionDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientProfileExtensionDto>
{
    Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId);
}
