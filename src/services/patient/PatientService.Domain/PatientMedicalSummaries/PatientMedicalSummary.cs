using System;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.PatientMedicalSummaries;

public class PatientMedicalSummary : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; protected set; }
    public string? BloodGroup { get; protected set; }
    public string? Allergies { get; protected set; }
    public string? ChronicConditions { get; protected set; }
    public string? Notes { get; protected set; }
    public Guid? TenantId { get; set; }

    protected PatientMedicalSummary()
    {
    }

    public PatientMedicalSummary(Guid id, Guid identityPatientId, Guid? tenantId = null)
        : base(id)
    {
        IdentityPatientId = identityPatientId;
        TenantId = tenantId;
    }

    public void SetIdentityPatientId(Guid identityPatientId)
    {
        IdentityPatientId = identityPatientId;
    }

    public void UpdateDetails(string? bloodGroup, string? allergies, string? chronicConditions, string? notes)
    {
        BloodGroup = bloodGroup;
        Allergies = allergies;
        ChronicConditions = chronicConditions;
        Notes = notes;
    }
}
