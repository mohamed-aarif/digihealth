using System;
using PatientService.ExternalLinks;
using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;

namespace PatientService.ExternalLinks;

public class PatientExternalLink : AggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; private set; }
    public Guid? TenantId { get; private set; }

    public string SystemName { get; private set; }
    public string ExternalReference { get; private set; }

    protected PatientExternalLink()
    {
        SystemName = string.Empty;
        ExternalReference = string.Empty;
    }

    public PatientExternalLink(
        Guid id,
        Guid identityPatientId,
        Guid? tenantId,
        string systemName,
        string externalReference) : base(id)
    {
        IdentityPatientId = Check.NotNull(identityPatientId, nameof(identityPatientId));
        TenantId = tenantId;
        UpdateLink(systemName, externalReference);
    }

    public void UpdateLink(string systemName, string externalReference)
    {
        SystemName = Check.Length(systemName, nameof(systemName), PatientExternalLinkConsts.MaxSystemNameLength, minLength: 1);
        ExternalReference = Check.Length(externalReference, nameof(externalReference), PatientExternalLinkConsts.MaxExternalReferenceLength, minLength: 1);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }
}
