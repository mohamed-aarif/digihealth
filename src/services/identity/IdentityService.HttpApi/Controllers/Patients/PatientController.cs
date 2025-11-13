using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Patients;
using IdentityService.Patients.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Controllers.Patients;

[Route("api/identity/patients")]
public class PatientController : IdentityServiceController
{
    private readonly IPatientAppService _patientAppService;

    public PatientController(IPatientAppService patientAppService)
    {
        _patientAppService = patientAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _patientAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<PatientDto>> GetAsync(Guid id)
    {
        try
        {
            return await _patientAppService.GetAsync(id);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpPost]
    public Task<PatientDto> CreateAsync([FromBody] CreateUpdatePatientDto input)
    {
        return _patientAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<PatientDto>> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientDto input)
    {
        try
        {
            return await _patientAppService.UpdateAsync(id, input);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteAsync(Guid id)
    {
        try
        {
            await _patientAppService.DeleteAsync(id);
            return NoContent();
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }
}
