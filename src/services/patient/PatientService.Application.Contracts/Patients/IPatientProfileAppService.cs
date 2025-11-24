using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.Patients;

public interface IPatientProfileAppService :
    ICrudAppService<
        PatientProfileExtensionDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdatePatientProfileExtensionDto>
{
    Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId);
}
