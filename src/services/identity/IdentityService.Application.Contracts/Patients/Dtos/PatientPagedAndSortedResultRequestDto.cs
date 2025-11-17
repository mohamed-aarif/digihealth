using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Patients.Dtos;

public class PatientPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public string? NameFilter { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public Guid? TenantId { get; set; }
}
