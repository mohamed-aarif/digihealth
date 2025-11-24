using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Dtos.MedicalSummaries;

public class CreateUpdatePatientMedicalSummaryDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [MaxLength(PatientMedicalSummaryConsts.MaxBloodGroupLength)]
    public string? BloodGroup { get; set; }

    [MaxLength(PatientMedicalSummaryConsts.MaxAllergiesLength)]
    public string? Allergies { get; set; }

    [MaxLength(PatientMedicalSummaryConsts.MaxChronicConditionsLength)]
    public string? ChronicConditions { get; set; }

    [MaxLength(PatientMedicalSummaryConsts.MaxNotesLength)]
    public string? Notes { get; set; }
}
