using System;
using System.ComponentModel.DataAnnotations.Schema;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.PatientProfiles;

[Table("patient_profile_extensions", Schema = PatientServiceDbProperties.DbSchema)]
public class PatientProfileExtension : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; protected set; }
    public string? PrimaryContactNumber { get; protected set; }
    public string? SecondaryContactNumber { get; protected set; }
    public string? Email { get; protected set; }
    public string? AddressLine1 { get; protected set; }
    public string? AddressLine2 { get; protected set; }
    public string? City { get; protected set; }
    public string? State { get; protected set; }
    public string? ZipCode { get; protected set; }
    public string? Country { get; protected set; }
    public string? EmergencyContactName { get; protected set; }
    public string? EmergencyContactNumber { get; protected set; }
    public string? PreferredLanguage { get; protected set; }
    public Guid? TenantId { get; set; }

    protected PatientProfileExtension()
    {
    }

    public PatientProfileExtension(Guid id, Guid identityPatientId, Guid? tenantId = null)
        : base(id)
    {
        IdentityPatientId = identityPatientId;
        TenantId = tenantId;
    }

    public void SetIdentityPatientId(Guid identityPatientId)
    {
        IdentityPatientId = identityPatientId;
    }

    public void UpdateContact(string? primary, string? secondary, string? email)
    {
        PrimaryContactNumber = primary;
        SecondaryContactNumber = secondary;
        Email = email;
    }

    public void UpdateAddress(string? address1, string? address2, string? city, string? state, string? zip, string? country)
    {
        AddressLine1 = address1;
        AddressLine2 = address2;
        City = city;
        State = state;
        ZipCode = zip;
        Country = country;
    }

    public void UpdateEmergencyContact(string? name, string? number)
    {
        EmergencyContactName = name;
        EmergencyContactNumber = number;
    }

    public void UpdatePreferredLanguage(string? language)
    {
        PreferredLanguage = language;
    }
}
