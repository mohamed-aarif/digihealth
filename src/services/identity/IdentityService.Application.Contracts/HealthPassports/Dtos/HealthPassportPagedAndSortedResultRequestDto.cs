using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.HealthPassports.Dtos;

public class HealthPassportPagedAndSortedResultRequestDto : PagedAndSortedResultRequestDto
{
    public Guid? TenantId { get; set; }
    public Guid? PatientId { get; set; }
    public string? PassportType { get; set; }
    public string? Status { get; set; }
}
