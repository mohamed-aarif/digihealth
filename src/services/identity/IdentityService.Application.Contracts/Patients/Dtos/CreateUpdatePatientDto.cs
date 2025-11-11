using System;
using System.ComponentModel.DataAnnotations;
using IdentityService.Patients;

namespace IdentityService.Patients.Dtos;

public class CreateUpdatePatientDto
{
    [Required]
    public Guid IdentityUserId { get; set; }

    [Required]
    [StringLength(PatientConsts.MaxMedicalRecordNumberLength)]
    public string MedicalRecordNumber { get; set; } = string.Empty;

    [Required]
    [StringLength(PatientConsts.MaxNameLength)]
    public string FirstName { get; set; } = string.Empty;

    [Required]
    [StringLength(PatientConsts.MaxNameLength)]
    public string LastName { get; set; } = string.Empty;

    public DateTime DateOfBirth { get; set; }

    public string? Gender { get; set; }

    [StringLength(PatientConsts.MaxPhoneLength)]
    public string? PhoneNumber { get; set; }

    [StringLength(PatientConsts.MaxEmailLength)]
    public string? Email { get; set; }

    public string? Address { get; set; }

    public Guid? PrimaryDoctorId { get; set; }
}
