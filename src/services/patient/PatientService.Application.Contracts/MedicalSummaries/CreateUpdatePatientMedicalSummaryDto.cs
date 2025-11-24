using System;
using System.ComponentModel.DataAnnotations;
using PatientService.MedicalSummaries;

namespace PatientService.MedicalSummaries;

public class CreateUpdatePatientMedicalSummaryDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [StringLength(PatientMedicalSummaryConsts.MaxBloodGroupLength)]
    public string? BloodGroup { get; set; }

    [StringLength(PatientMedicalSummaryConsts.MaxAllergiesLength)]
    public string? Allergies { get; set; }

    [StringLength(PatientMedicalSummaryConsts.MaxChronicConditionsLength)]
    public string? ChronicConditions { get; set; }

    [StringLength(PatientMedicalSummaryConsts.MaxNotesLength)]
    public string? Notes { get; set; }
}
