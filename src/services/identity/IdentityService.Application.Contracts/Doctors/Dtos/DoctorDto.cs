using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Doctors.Dtos;

public class DoctorDto : EntityDto<Guid>
{
    public Guid UserId { get; set; }
    public Guid? TenantId { get; set; }
    public string? Salutation { get; set; }
    public string? Gender { get; set; }
    public string? Specialization { get; set; }
    public string? RegistrationNumber { get; set; }
    public DateTime CreationTime { get; set; }
    public string? UserName { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? ProfilePhotoUrl { get; set; }
}
