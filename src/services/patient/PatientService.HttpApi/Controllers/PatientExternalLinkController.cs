using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Patients;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/external-links")]
public class PatientExternalLinkController : PatientServiceController
{
    private readonly IPatientExternalLinkAppService _patientExternalLinkAppService;

    public PatientExternalLinkController(IPatientExternalLinkAppService patientExternalLinkAppService)
    {
        _patientExternalLinkAppService = patientExternalLinkAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientExternalLinkDto>> GetListAsync(PatientExternalLinkPagedAndSortedResultRequestDto input)
    {
        return _patientExternalLinkAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<PatientExternalLinkDto> GetAsync(Guid id)
    {
        return _patientExternalLinkAppService.GetAsync(id);
    }

    [HttpPost]
    public Task<PatientExternalLinkDto> CreateAsync(CreateUpdatePatientExternalLinkDto input)
    {
        return _patientExternalLinkAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientExternalLinkDto> UpdateAsync(Guid id, CreateUpdatePatientExternalLinkDto input)
    {
        return _patientExternalLinkAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _patientExternalLinkAppService.DeleteAsync(id);
    }
}
