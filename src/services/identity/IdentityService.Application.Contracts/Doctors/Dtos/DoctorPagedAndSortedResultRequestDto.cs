using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Doctors.Dtos;

public class DoctorPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public string? NameFilter { get; set; }
    public string? SpecializationFilter { get; set; }
    public Guid? TenantId { get; set; }
}
