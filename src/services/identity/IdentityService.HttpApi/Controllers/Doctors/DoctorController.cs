using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Doctors;
using IdentityService.Doctors.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Controllers.Doctors;

[Route("api/identity/doctors")]
public class DoctorController : IdentityServiceController
{
    private readonly IDoctorAppService _doctorAppService;

    public DoctorController(IDoctorAppService doctorAppService)
    {
        _doctorAppService = doctorAppService;
    }

    [HttpGet]
    public Task<PagedResultDto<DoctorDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _doctorAppService.GetListAsync(input);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<DoctorDto>> GetAsync(Guid id)
    {
        try
        {
            return await _doctorAppService.GetAsync(id);
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpPost]
    public Task<DoctorDto> CreateAsync([FromBody] CreateUpdateDoctorDto input)
    {
        return _doctorAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<DoctorDto>> UpdateAsync(Guid id, [FromBody] CreateUpdateDoctorDto input)
    {
        try
        {
            return await _doctorAppService.UpdateAsync(id, input);
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
            await _doctorAppService.DeleteAsync(id);
            return NoContent();
        }
        catch (EntityNotFoundException)
        {
            return NotFound();
        }
    }
}
