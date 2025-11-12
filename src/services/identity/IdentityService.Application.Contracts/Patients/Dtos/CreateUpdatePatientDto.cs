using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.Patients.Dtos;

public class CreateUpdatePatientDto
{
    [Required]
    public Guid UserId { get; set; }

    [Required]
    [StringLength(PatientConsts.MaxFullNameLength)]
    public string FullName { get; set; } = string.Empty;

    public DateTime? DateOfBirth { get; set; }

    [StringLength(PatientConsts.MaxGenderLength)]
    public string? Gender { get; set; }

    [StringLength(PatientConsts.MaxCountryLength)]
    public string? Country { get; set; }

    [StringLength(PatientConsts.MaxMobileNumberLength)]
    public string? MobileNumber { get; set; }

    [StringLength(PatientConsts.MaxHealthVaultIdLength)]
    public string? HealthVaultId { get; set; }
}
