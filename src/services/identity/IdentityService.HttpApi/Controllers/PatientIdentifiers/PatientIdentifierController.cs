using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.PatientIdentifiers;
using IdentityService.PatientIdentifiers.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Controllers.PatientIdentifiers;

[Route("api/identity/patient-identifiers")]
public class PatientIdentifierController : IdentityServiceController
{
    private readonly IPatientIdentifierAppService _appService;

    public PatientIdentifierController(IPatientIdentifierAppService appService)
    {
        _appService = appService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientIdentifierDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _appService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<PatientIdentifierDto>> GetAsync(Guid id)
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
    public Task<PatientIdentifierDto> CreateAsync([FromBody] CreateUpdatePatientIdentifierDto input)
    {
        return _appService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<PatientIdentifierDto>> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientIdentifierDto input)
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
