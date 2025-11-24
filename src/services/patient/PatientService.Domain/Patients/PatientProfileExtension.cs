using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Patients;

public class PatientProfileExtension : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
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
    public Guid? TenantId { get; private set; }

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
        IdentityPatientId = Check.NotNull(identityPatientId, nameof(identityPatientId));
        TenantId = tenantId;
        UpdateContact(primaryContactNumber, secondaryContactNumber, email);
        UpdateAddress(addressLine1, addressLine2, city, state, zipCode, country);
        UpdateEmergencyContact(emergencyContactName, emergencyContactNumber);
        PreferredLanguage = preferredLanguage;
    }

    public void UpdateContact(string? primaryContactNumber, string? secondaryContactNumber, string? email)
    {
        PrimaryContactNumber = primaryContactNumber?.Trim();
        SecondaryContactNumber = secondaryContactNumber?.Trim();
        Email = email?.Trim();
    }

    public void UpdateAddress(string? addressLine1, string? addressLine2, string? city, string? state, string? zipCode, string? country)
    {
        AddressLine1 = addressLine1?.Trim();
        AddressLine2 = addressLine2?.Trim();
        City = city?.Trim();
        State = state?.Trim();
        ZipCode = zipCode?.Trim();
        Country = country?.Trim();
    }

    public void UpdateEmergencyContact(string? name, string? number)
    {
        EmergencyContactName = name?.Trim();
        EmergencyContactNumber = number?.Trim();
    }

    public void SetPreferredLanguage(string? language)
    {
        PreferredLanguage = language?.Trim();
    }
}
