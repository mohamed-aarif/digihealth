using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.PatientMedicalSummaries;

public class CreateUpdatePatientMedicalSummaryDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }
    [StringLength(32)]
    public string? BloodGroup { get; set; }
    [StringLength(512)]
    public string? Allergies { get; set; }
    [StringLength(512)]
    public string? ChronicConditions { get; set; }
    [StringLength(2048)]
    public string? Notes { get; set; }
}
