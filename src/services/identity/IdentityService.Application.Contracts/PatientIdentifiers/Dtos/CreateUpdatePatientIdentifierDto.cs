using System;
using System.ComponentModel.DataAnnotations;
using IdentityService.PatientIdentifiers;

namespace IdentityService.PatientIdentifiers.Dtos;

public class CreateUpdatePatientIdentifierDto
{
    [Required]
    public Guid PatientId { get; set; }

    [Required]
    [StringLength(PatientIdentifierConsts.MaxIdTypeLength)]
    public string IdType { get; set; } = string.Empty;

    [Required]
    [StringLength(PatientIdentifierConsts.MaxIdNumberLength)]
    public string IdNumber { get; set; } = string.Empty;

    [StringLength(PatientIdentifierConsts.MaxIssuerCountryLength)]
    public string? IssuerCountry { get; set; }

    public DateTime? IssueDate { get; set; }
    public DateTime? ExpiryDate { get; set; }

    [StringLength(PatientIdentifierConsts.MaxNotesLength)]
    public string? Notes { get; set; }

    public Guid? RecordId { get; set; }
}
