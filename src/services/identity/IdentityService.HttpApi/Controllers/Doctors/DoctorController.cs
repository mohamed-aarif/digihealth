using System;
using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Doctors;
using IdentityService.Doctors.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;

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
    public Task<DoctorDto> GetAsync(Guid id)
    {
        return _doctorAppService.GetAsync(id);
    }

    [HttpPost]
    public Task<DoctorDto> CreateAsync([FromBody] CreateUpdateDoctorDto input)
    {
        return _doctorAppService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<DoctorDto> UpdateAsync(Guid id, [FromBody] CreateUpdateDoctorDto input)
    {
        return _doctorAppService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _doctorAppService.DeleteAsync(id);
    }
}
