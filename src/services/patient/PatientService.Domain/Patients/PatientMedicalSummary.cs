using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Patients;

public class PatientMedicalSummary : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
    public string? BloodGroup { get; private set; }
    public string? Allergies { get; private set; }
    public string? ChronicConditions { get; private set; }
    public string? Notes { get; private set; }
    public Guid? TenantId { get; private set; }

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
        IdentityPatientId = Check.NotNull(identityPatientId, nameof(identityPatientId));
        TenantId = tenantId;
        UpdateSummary(bloodGroup, allergies, chronicConditions, notes);
    }

    public void UpdateSummary(string? bloodGroup, string? allergies, string? chronicConditions, string? notes)
    {
        BloodGroup = bloodGroup?.Trim();
        Allergies = allergies?.Trim();
        ChronicConditions = chronicConditions?.Trim();
        Notes = notes?.Trim();
    }
}
