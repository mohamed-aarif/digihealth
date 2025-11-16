using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.PatientInsurances;
using IdentityService.PatientInsurances.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Controllers.PatientInsurances;

[Route("api/identity/patient-insurances")]
public class PatientInsuranceController : IdentityServiceController
{
    private readonly IPatientInsuranceAppService _appService;

    public PatientInsuranceController(IPatientInsuranceAppService appService)
    {
        _appService = appService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientInsuranceDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _appService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<PatientInsuranceDto>> GetAsync(Guid id)
    {
        try
        {
            return await _appService.GetAsync(id);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpPost]
    public Task<PatientInsuranceDto> CreateAsync([FromBody] CreateUpdatePatientInsuranceDto input)
    {
        return _appService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<PatientInsuranceDto>> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientInsuranceDto input)
    {
        try
        {
            return await _appService.UpdateAsync(id, input);
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
            await _appService.DeleteAsync(id);
            return NoContent();
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }
}
