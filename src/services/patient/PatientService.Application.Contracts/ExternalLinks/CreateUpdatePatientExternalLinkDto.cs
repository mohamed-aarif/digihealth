using System;
using System.ComponentModel.DataAnnotations;
using PatientService.ExternalLinks;

namespace PatientService.ExternalLinks;

public class CreateUpdatePatientExternalLinkDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [Required]
    [StringLength(PatientExternalLinkConsts.MaxSystemNameLength)]
    public string SystemName { get; set; } = string.Empty;

    [Required]
    [StringLength(PatientExternalLinkConsts.MaxExternalReferenceLength)]
    public string ExternalReference { get; set; } = string.Empty;
}
