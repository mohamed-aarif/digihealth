using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Patients;

public class CreateUpdatePatientExternalLinkDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [Required]
    [StringLength(128)]
    public string SystemName { get; set; } = string.Empty;

    [Required]
    [StringLength(256)]
    public string ExternalReference { get; set; } = string.Empty;
}
