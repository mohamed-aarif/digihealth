using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Dtos.Profiles;
using PatientService.Profiles;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/profiles")]
public class PatientProfilesController : PatientServiceController
{
    private readonly IPatientProfileAppService _appService;

    public PatientProfilesController(IPatientProfileAppService appService)
    {
        _appService = appService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientProfileExtensionDto>> GetListAsync(PagedAndSortedResultRequestDto input)
    {
        return _appService.GetListAsync(input);
    }

    [HttpGet("by-identity/{identityPatientId}")]
    public Task<PatientProfileExtensionDto?> GetByIdentityAsync(Guid identityPatientId)
    {
        return _appService.GetByIdentityPatientIdAsync(identityPatientId);
    }

    [HttpGet("{id}")]
    public Task<PatientProfileExtensionDto> GetAsync(Guid id)
    {
        return _appService.GetAsync(id);
    }

    [HttpPost]
    public Task<PatientProfileExtensionDto> CreateAsync([FromBody] CreateUpdatePatientProfileExtensionDto input)
    {
        return _appService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientProfileExtensionDto> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientProfileExtensionDto input)
    {
        return _appService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _appService.DeleteAsync(id);
    }
}
