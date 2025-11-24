using System;
using PatientService.PatientProfiles;
using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;

namespace PatientService.PatientProfiles;

public class PatientProfileExtension : AggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
    public Guid? TenantId { get; private set; }

    public string? PrimaryContactNumber { get; private set; }
    public string? SecondaryContactNumber { get; private set; }
    public string? Email { get; private set; }
    public string? AddressLine1 { get; private set; }
    public string? AddressLine2 { get; private set; }
    public string? City { get; private set; }
    public string? State { get; private set; }
    public string? ZipCode { get; private set; }
    public string? Country { get; private set; }
    public string? EmergencyContactName { get; private set; }
    public string? EmergencyContactNumber { get; private set; }
    public string? PreferredLanguage { get; private set; }

    protected PatientProfileExtension()
    {
    }

    public PatientProfileExtension(
        Guid id,
        Guid identityPatientId,
        Guid? tenantId,
        string? primaryContactNumber,
        string? secondaryContactNumber,
        string? email,
        string? addressLine1,
        string? addressLine2,
        string? city,
        string? state,
        string? zipCode,
        string? country,
        string? emergencyContactName,
        string? emergencyContactNumber,
        string? preferredLanguage) : base(id)
    {
        SetIdentityPatient(identityPatientId);
        TenantId = tenantId;
        UpdateContact(primaryContactNumber, secondaryContactNumber, email, preferredLanguage);
        UpdateAddress(addressLine1, addressLine2, city, state, zipCode, country);
        UpdateEmergencyContact(emergencyContactName, emergencyContactNumber);
    }

    public void UpdateContact(string? primaryContact, string? secondaryContact, string? email, string? preferredLanguage)
    {
        PrimaryContactNumber = primaryContact.IsNullOrWhiteSpace()
            ? null
            : Check.Length(primaryContact, nameof(primaryContact), PatientProfileExtensionConsts.MaxPrimaryContactLength);
        SecondaryContactNumber = secondaryContact.IsNullOrWhiteSpace()
            ? null
            : Check.Length(secondaryContact, nameof(secondaryContact), PatientProfileExtensionConsts.MaxSecondaryContactLength);
        Email = email.IsNullOrWhiteSpace()
            ? null
            : Check.Length(email, nameof(email), PatientProfileExtensionConsts.MaxEmailLength);
        PreferredLanguage = preferredLanguage.IsNullOrWhiteSpace()
            ? null
            : Check.Length(preferredLanguage, nameof(preferredLanguage), PatientProfileExtensionConsts.MaxPreferredLanguageLength);
    }

    public void UpdateAddress(string? addressLine1, string? addressLine2, string? city, string? state, string? zipCode, string? country)
    {
        AddressLine1 = addressLine1.IsNullOrWhiteSpace()
            ? null
            : Check.Length(addressLine1, nameof(addressLine1), PatientProfileExtensionConsts.MaxAddressLineLength);
        AddressLine2 = addressLine2.IsNullOrWhiteSpace()
            ? null
            : Check.Length(addressLine2, nameof(addressLine2), PatientProfileExtensionConsts.MaxAddressLineLength);
        City = city.IsNullOrWhiteSpace()
            ? null
            : Check.Length(city, nameof(city), PatientProfileExtensionConsts.MaxCityLength);
        State = state.IsNullOrWhiteSpace()
            ? null
            : Check.Length(state, nameof(state), PatientProfileExtensionConsts.MaxStateLength);
        ZipCode = zipCode.IsNullOrWhiteSpace()
            ? null
            : Check.Length(zipCode, nameof(zipCode), PatientProfileExtensionConsts.MaxZipCodeLength);
        Country = country.IsNullOrWhiteSpace()
            ? null
            : Check.Length(country, nameof(country), PatientProfileExtensionConsts.MaxCountryLength);
    }

    public void UpdateEmergencyContact(string? name, string? contactNumber)
    {
        EmergencyContactName = name.IsNullOrWhiteSpace()
            ? null
            : Check.Length(name, nameof(name), PatientProfileExtensionConsts.MaxEmergencyContactNameLength);
        EmergencyContactNumber = contactNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(contactNumber, nameof(contactNumber), PatientProfileExtensionConsts.MaxEmergencyContactNumberLength);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetIdentityPatient(Guid identityPatientId)
    {
        IdentityPatientId = Check.NotNull(identityPatientId, nameof(identityPatientId));
    }
}
