using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Doctors.Dtos;

public class DoctorDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityUserId { get; set; }
    public string LicenseNumber { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? Specialty { get; set; }
}
