using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Patients;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/profiles")]
public class PatientProfileController : PatientServiceController
{
    private readonly IPatientProfileAppService _patientProfileAppService;

    public PatientProfileController(IPatientProfileAppService patientProfileAppService)
    {
        _patientProfileAppService = patientProfileAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientProfileExtensionDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _patientProfileAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<PatientProfileExtensionDto> GetAsync(Guid id)
    {
        return _patientProfileAppService.GetAsync(id);
    }

    [HttpGet("by-identity/{identityPatientId}")]
    public Task<PatientProfileExtensionDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        return _patientProfileAppService.GetByIdentityPatientIdAsync(identityPatientId);
    }

    [HttpPost]
    public Task<PatientProfileExtensionDto> CreateAsync(CreateUpdatePatientProfileExtensionDto input)
    {
        return _patientProfileAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientProfileExtensionDto> UpdateAsync(Guid id, CreateUpdatePatientProfileExtensionDto input)
    {
        return _patientProfileAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _patientProfileAppService.DeleteAsync(id);
    }
}
