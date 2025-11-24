using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.ExternalLinks;

public class PatientExternalLinkDto : EntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public Guid? TenantId { get; set; }
    public string SystemName { get; set; } = string.Empty;
    public string ExternalReference { get; set; } = string.Empty;
}
