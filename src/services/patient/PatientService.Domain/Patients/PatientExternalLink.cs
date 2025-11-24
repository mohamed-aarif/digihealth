using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Patients;

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

    public PatientExternalLink(
        Guid id,
        Guid identityPatientId,
        Guid? tenantId,
        string systemName,
        string externalReference) : base(id)
    {
        IdentityPatientId = Check.NotNull(identityPatientId, nameof(identityPatientId));
        TenantId = tenantId;
        SystemName = Check.NotNullOrWhiteSpace(systemName, nameof(systemName));
        ExternalReference = Check.NotNullOrWhiteSpace(externalReference, nameof(externalReference));
    }

    public void UpdateReference(string systemName, string externalReference)
    {
        SystemName = Check.NotNullOrWhiteSpace(systemName, nameof(systemName));
        ExternalReference = Check.NotNullOrWhiteSpace(externalReference, nameof(externalReference));
    }
}
