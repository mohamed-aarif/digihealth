using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Patients;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/medical-summaries")]
public class PatientMedicalSummaryController : PatientServiceController
{
    private readonly IPatientMedicalSummaryAppService _patientMedicalSummaryAppService;

    public PatientMedicalSummaryController(IPatientMedicalSummaryAppService patientMedicalSummaryAppService)
    {
        _patientMedicalSummaryAppService = patientMedicalSummaryAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientMedicalSummaryDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _patientMedicalSummaryAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<PatientMedicalSummaryDto> GetAsync(Guid id)
    {
        return _patientMedicalSummaryAppService.GetAsync(id);
    }

    [HttpGet("by-identity/{identityPatientId}")]
    public Task<PatientMedicalSummaryDto?> GetByIdentityPatientIdAsync(Guid identityPatientId)
    {
        return _patientMedicalSummaryAppService.GetByIdentityPatientIdAsync(identityPatientId);
    }

    [HttpPost]
    public Task<PatientMedicalSummaryDto> CreateAsync(CreateUpdatePatientMedicalSummaryDto input)
    {
        return _patientMedicalSummaryAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientMedicalSummaryDto> UpdateAsync(Guid id, CreateUpdatePatientMedicalSummaryDto input)
    {
        return _patientMedicalSummaryAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _patientMedicalSummaryAppService.DeleteAsync(id);
    }
}
