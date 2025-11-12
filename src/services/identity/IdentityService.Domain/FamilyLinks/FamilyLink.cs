using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;

namespace IdentityService.FamilyLinks;

public class FamilyLink : FullAuditedAggregateRoot<Guid>
{
    public Guid PatientId { get; private set; }
    public Guid RelatedPatientId { get; private set; }
    public string Relationship { get; private set; }

    private FamilyLink()
    {
        Relationship = string.Empty;
    }

    public FamilyLink(Guid id, Guid patientId, Guid relatedPatientId, string relationship) : base(id)
    {
        SetPatients(patientId, relatedPatientId);
        SetRelationship(relationship);
    }

    public void SetPatients(Guid patientId, Guid relatedPatientId)
    {
        PatientId = patientId;
        RelatedPatientId = relatedPatientId;
    }

    public void SetRelationship(string relationship)
    {
        Relationship = Check.NotNullOrWhiteSpace(relationship, nameof(relationship), FamilyLinkConsts.MaxRelationshipLength);
    }

    public void Update(Guid patientId, Guid relatedPatientId, string relationship)
    {
        SetPatients(patientId, relatedPatientId);
        SetRelationship(relationship);
    }
}
