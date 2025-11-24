using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Patients;

public class PatientExternalLinkPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? IdentityPatientId { get; set; }
    public string? SystemName { get; set; }
}
