using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Dtos.Profiles;

public class CreateUpdatePatientProfileExtensionDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength)]
    public string? PrimaryContactNumber { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength)]
    public string? SecondaryContactNumber { get; set; }

    [EmailAddress]
    [MaxLength(PatientProfileExtensionConsts.MaxEmailLength)]
    public string? Email { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxAddressLength)]
    public string? AddressLine1 { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxAddressLength)]
    public string? AddressLine2 { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxCityLength)]
    public string? City { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxStateLength)]
    public string? State { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxZipCodeLength)]
    public string? ZipCode { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxCountryLength)]
    public string? Country { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxEmergencyContactLength)]
    public string? EmergencyContactName { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxPhoneNumberLength)]
    public string? EmergencyContactNumber { get; set; }

    [MaxLength(PatientProfileExtensionConsts.MaxPreferredLanguageLength)]
    public string? PreferredLanguage { get; set; }
}
