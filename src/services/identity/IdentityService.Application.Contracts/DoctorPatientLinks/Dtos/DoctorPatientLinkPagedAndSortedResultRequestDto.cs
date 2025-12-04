using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.DoctorPatientLinks.Dtos;

public class DoctorPatientLinkPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? TenantId { get; set; }
    public Guid? DoctorId { get; set; }
    public Guid? PatientId { get; set; }
}
