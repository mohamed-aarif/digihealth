using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Doctors.Dtos;

public class DoctorDto : EntityDto<Guid>
{
    public Guid UserId { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string? Salutation { get; set; }
    public string? Gender { get; set; }
    public string? Specialty { get; set; }
    public string? RegistrationNumber { get; set; }
    public string? ClinicName { get; set; }
    public DateTime CreatedAt { get; set; }
    public string? PhotoStorageKey { get; set; }
}
