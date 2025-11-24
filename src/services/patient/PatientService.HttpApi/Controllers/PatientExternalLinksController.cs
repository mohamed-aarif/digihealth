using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PatientService.Dtos.ExternalLinks;
using PatientService.ExternalLinks;
using Volo.Abp.Application.Dtos;

namespace PatientService.Controllers;

[Route("api/patient-service/external-links")]
public class PatientExternalLinksController : PatientServiceController
{
    private readonly IPatientExternalLinkAppService _appService;

    public PatientExternalLinksController(IPatientExternalLinkAppService appService)
    {
        _appService = appService;
    }

    [HttpGet]
    public Task<PagedResultDto<PatientExternalLinkDto>> GetListAsync(Guid identityPatientId, string? systemName)
    {
        return _appService.GetListAsync(identityPatientId, systemName);
    }

    [HttpGet("{id}")]
    public Task<PatientExternalLinkDto> GetAsync(Guid id)
    {
        return _appService.GetAsync(id);
    }

    [HttpPost]
    public Task<PatientExternalLinkDto> CreateAsync([FromBody] CreateUpdatePatientExternalLinkDto input)
    {
        return _appService.CreateAsync(input);
    }

    [HttpPut("{id}")]
    public Task<PatientExternalLinkDto> UpdateAsync(Guid id, [FromBody] CreateUpdatePatientExternalLinkDto input)
    {
        return _appService.UpdateAsync(id, input);
    }

    [HttpDelete("{id}")]
    public Task DeleteAsync(Guid id)
    {
        return _appService.DeleteAsync(id);
    }
}
