using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Dtos.MedicalSummaries;
using PatientService.MedicalSummaries;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/medical-summaries")]
public class PatientMedicalSummariesController : PatientServiceController
{
    private readonly IPatientMedicalSummaryAppService _appService;

    public PatientMedicalSummariesController(IPatientMedicalSummaryAppService appService)
    {
        _appService = appService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientMedicalSummaryDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _appService.GetListAsync(input);
    }

    [HttpGet("by-identity/{identityPatientId}")]
    public Task<PatientMedicalSummaryDto?> GetByIdentityAsync(Guid identityPatientId)
    {
        return _appService.GetByIdentityPatientIdAsync(identityPatientId);
    }

    [HttpGet("{id}")]
    public Task<PatientMedicalSummaryDto> GetAsync(Guid id)
    {
        return _appService.GetAsync(id);
    }

    [HttpPost]
    public Task<PatientMedicalSummaryDto> CreateAsync([FromBody] CreateUpdatePatientMedicalSummaryDto input)
    {
        return _appService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientMedicalSummaryDto> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientMedicalSummaryDto input)
    {
        return _appService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _appService.DeleteAsync(id);
    }
}
