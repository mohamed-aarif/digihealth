using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.FamilyLinks;

public class FamilyLink : AggregateRoot<Guid>
{
    public Guid PatientId { get; private set; }
    public Guid FamilyUserId { get; private set; }
    public string Relationship { get; private set; }
    public bool IsGuardian { get; private set; }
    public DateTime CreatedAt { get; private set; }

    private FamilyLink()
    {
        Relationship = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public FamilyLink(Guid id, Guid patientId, Guid familyUserId, string relationship, bool isGuardian) : base(id)
    {
        SetParticipants(patientId, familyUserId);
        SetRelationship(relationship);
        IsGuardian = isGuardian;
        CreatedAt = DateTime.UtcNow;
    }

    public void SetParticipants(Guid patientId, Guid familyUserId)
    {
        PatientId = patientId;
        FamilyUserId = familyUserId;
    }

    public void SetRelationship(string relationship)
    {
        Relationship = Check.NotNullOrWhiteSpace(relationship, nameof(relationship), FamilyLinkConsts.MaxRelationshipLength);
    }

    public void Update(Guid patientId, Guid familyUserId, string relationship, bool isGuardian)
    {
        SetParticipants(patientId, familyUserId);
        SetRelationship(relationship);
        IsGuardian = isGuardian;
    }
}
