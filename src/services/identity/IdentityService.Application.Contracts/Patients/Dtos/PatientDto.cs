using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Patients.Dtos;

public class PatientDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityUserId { get; set; }
    public string MedicalRecordNumber { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Email { get; set; }
    public string? Address { get; set; }
    public Guid? PrimaryDoctorId { get; set; }
}
