using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Dtos.ExternalLinks;

public class CreateUpdatePatientExternalLinkDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [Required]
    [MaxLength(PatientExternalLinkConsts.MaxSystemNameLength)]
    public string SystemName { get; set; } = string.Empty;

    [Required]
    [MaxLength(PatientExternalLinkConsts.MaxExternalReferenceLength)]
    public string ExternalReference { get; set; } = string.Empty;
}
