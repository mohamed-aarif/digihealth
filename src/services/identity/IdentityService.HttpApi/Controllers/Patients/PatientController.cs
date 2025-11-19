using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Patients;
using IdentityService.Patients.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Controllers.Patients;

[Route("api/identity-service/patients")]
public class PatientController : IdentityServiceController
{
    private readonly IPatientAppService _patientAppService;

    public PatientController(IPatientAppService patientAppService)
    {
        _patientAppService = patientAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientDto>> GetListAsync([FromQuery] PatientPagedAndSortedResultRequestDto input)
    {
        return _patientAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public Task<PatientDto> GetAsync(Guid id)
    {
        return _patientAppService.GetAsync(id);
    }

    [HttpPost]
    public Task<PatientDto> CreateAsync([FromBody] CreateUpdatePatientDto input)
    {
        return _patientAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientDto> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientDto input)
    {
        return _patientAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _patientAppService.DeleteAsync(id);
    }
}
