using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.ExternalLinks;

public class PatientExternalLinkGetListInput : PagedAndSortedResultRequestDto
{
    public Guid? IdentityPatientId { get; set; }
    public string? SystemName { get; set; }
}
