using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.PatientMedicalSummaries;

public class CreateUpdatePatientMedicalSummaryDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [StringLength(8)]
    public string? BloodGroup { get; set; }

    public string? Allergies { get; set; }

    public string? ChronicConditions { get; set; }

    public string? Notes { get; set; }
}
