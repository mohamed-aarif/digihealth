using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.Patients.Dtos;

public class CreatePatientDto
{
    [Required]
    public Guid UserId { get; set; }

    [StringLength(PatientConsts.MaxSalutationLength)]
    public string? Salutation { get; set; }

    public DateTime? DateOfBirth { get; set; }

    [StringLength(PatientConsts.MaxGenderLength)]
    public string? Gender { get; set; }

    [StringLength(PatientConsts.MaxResidenceCountryLength)]
    public string? ResidenceCountry { get; set; }
}
