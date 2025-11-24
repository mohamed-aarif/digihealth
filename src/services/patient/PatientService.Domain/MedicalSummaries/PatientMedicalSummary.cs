using System;
using PatientService.MedicalSummaries;
using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;

namespace PatientService.MedicalSummaries;

public class PatientMedicalSummary : AggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
    public Guid? TenantId { get; private set; }

    public string? BloodGroup { get; private set; }
    public string? Allergies { get; private set; }
    public string? ChronicConditions { get; private set; }
    public string? Notes { get; private set; }

    protected PatientMedicalSummary()
    {
    }

    public PatientMedicalSummary(
        Guid id,
        Guid identityPatientId,
        Guid? tenantId,
        string? bloodGroup,
        string? allergies,
        string? chronicConditions,
        string? notes) : base(id)
    {
        SetIdentityPatient(identityPatientId);
        TenantId = tenantId;
        UpdateSummary(bloodGroup, allergies, chronicConditions, notes);
    }

    public void UpdateSummary(string? bloodGroup, string? allergies, string? chronicConditions, string? notes)
    {
        BloodGroup = bloodGroup.IsNullOrWhiteSpace()
            ? null
            : Check.Length(bloodGroup, nameof(bloodGroup), PatientMedicalSummaryConsts.MaxBloodGroupLength);
        Allergies = allergies.IsNullOrWhiteSpace()
            ? null
            : Check.Length(allergies, nameof(allergies), PatientMedicalSummaryConsts.MaxAllergiesLength);
        ChronicConditions = chronicConditions.IsNullOrWhiteSpace()
            ? null
            : Check.Length(chronicConditions, nameof(chronicConditions), PatientMedicalSummaryConsts.MaxChronicConditionsLength);
        Notes = notes.IsNullOrWhiteSpace()
            ? null
            : Check.Length(notes, nameof(notes), PatientMedicalSummaryConsts.MaxNotesLength);
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
