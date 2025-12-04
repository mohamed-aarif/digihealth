using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.PatientExternalLinks;

public class PatientExternalLinkListRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? IdentityPatientId { get; set; }
    public string? SystemName { get; set; }
}
