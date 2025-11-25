using System;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.PatientExternalLinks;

public class PatientExternalLink : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; protected set; }
    public string SystemName { get; protected set; } = string.Empty;
    public string ExternalReference { get; protected set; } = string.Empty;
    public Guid? TenantId { get; set; }

    protected PatientExternalLink()
    {
    }

    public PatientExternalLink(Guid id, Guid identityPatientId, string systemName, string externalReference, Guid? tenantId = null)
        : base(id)
    {
        IdentityPatientId = identityPatientId;
        SystemName = systemName;
        ExternalReference = externalReference;
        TenantId = tenantId;
    }

    public void UpdateLink(string systemName, string externalReference)
    {
        SystemName = systemName;
        ExternalReference = externalReference;
    }
}
