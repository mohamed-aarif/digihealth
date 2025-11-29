using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.FamilyLinks;

public class FamilyLink : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public Guid PatientId { get; private set; }
    public Guid FamilyUserId { get; private set; }
    public string Relationship { get; private set; } = null!;
    public bool IsGuardian { get; private set; }

    protected FamilyLink()
    {
        this.SetDefaultsForExtraProperties();
    }

    public FamilyLink(
        Guid id,
        Guid? tenantId,
        Guid patientId,
        Guid familyUserId,
        string relationship,
        bool isGuardian) : base(id)
    {
        TenantId = tenantId;
        SetPatientId(patientId);
        SetFamilyUserId(familyUserId);
        SetRelationship(relationship);
        IsGuardian = isGuardian;
        this.SetDefaultsForExtraProperties();
    }

    public void Update(
        Guid patientId,
        Guid familyUserId,
        string relationship,
        bool isGuardian)
    {
        SetPatientId(patientId);
        SetFamilyUserId(familyUserId);
        SetRelationship(relationship);
        IsGuardian = isGuardian;
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetPatientId(Guid patientId)
    {
        PatientId = patientId;
    }

    private void SetFamilyUserId(Guid familyUserId)
    {
        FamilyUserId = familyUserId;
    }

    private void SetRelationship(string relationship)
    {
        Relationship = Check.Length(
            Check.NotNullOrWhiteSpace(relationship, nameof(relationship)),
            nameof(relationship),
            FamilyLinkConsts.MaxRelationshipLength,
            0);
    }
}
