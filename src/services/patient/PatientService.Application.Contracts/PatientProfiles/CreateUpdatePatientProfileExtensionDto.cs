using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.PatientProfiles;

public class CreateUpdatePatientProfileExtensionDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }
    [StringLength(64)]
    public string? PrimaryContactNumber { get; set; }
    [StringLength(64)]
    public string? SecondaryContactNumber { get; set; }
    [EmailAddress]
    [StringLength(256)]
    public string? Email { get; set; }
    [StringLength(256)]
    public string? AddressLine1 { get; set; }
    [StringLength(256)]
    public string? AddressLine2 { get; set; }
    [StringLength(128)]
    public string? City { get; set; }
    [StringLength(128)]
    public string? State { get; set; }
    [StringLength(32)]
    public string? ZipCode { get; set; }
    [StringLength(128)]
    public string? Country { get; set; }
    [StringLength(128)]
    public string? EmergencyContactName { get; set; }
    [StringLength(64)]
    public string? EmergencyContactNumber { get; set; }
    [StringLength(64)]
    public string? PreferredLanguage { get; set; }
}
