using System;
using System.ComponentModel.DataAnnotations;
using PatientService.PatientProfiles;

namespace PatientService.PatientProfiles;

public class CreateUpdatePatientProfileExtensionDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxPrimaryContactLength)]
    public string? PrimaryContactNumber { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxSecondaryContactLength)]
    public string? SecondaryContactNumber { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxEmailLength)]
    [EmailAddress]
    public string? Email { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxAddressLineLength)]
    public string? AddressLine1 { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxAddressLineLength)]
    public string? AddressLine2 { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxCityLength)]
    public string? City { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxStateLength)]
    public string? State { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxZipCodeLength)]
    public string? ZipCode { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxCountryLength)]
    public string? Country { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxEmergencyContactNameLength)]
    public string? EmergencyContactName { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxEmergencyContactNumberLength)]
    public string? EmergencyContactNumber { get; set; }

    [StringLength(PatientProfileExtensionConsts.MaxPreferredLanguageLength)]
    public string? PreferredLanguage { get; set; }
}
