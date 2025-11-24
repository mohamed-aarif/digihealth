using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Entities;

public class PatientExternalLink : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
    public string SystemName { get; private set; }
    public string ExternalReference { get; private set; }
    public Guid? TenantId { get; private set; }

    protected PatientExternalLink()
    {
        SystemName = string.Empty;
        ExternalReference = string.Empty;
    }

    public PatientExternalLink(Guid id, Guid identityPatientId, Guid? tenantId, string systemName, string externalReference) : base(id)
    {
        TenantId = tenantId;
        SetIdentityPatient(identityPatientId);
        UpdateLink(systemName, externalReference);
    }

    public void UpdateLink(string systemName, string externalReference)
    {
        SystemName = Check.Length(systemName, nameof(systemName), PatientExternalLinkConsts.MaxSystemNameLength);
        ExternalReference = Check.Length(externalReference, nameof(externalReference), PatientExternalLinkConsts.MaxExternalReferenceLength);
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
