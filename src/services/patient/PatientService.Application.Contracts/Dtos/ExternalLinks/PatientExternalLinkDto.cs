using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Dtos.ExternalLinks;

public class PatientExternalLinkDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public string SystemName { get; set; } = string.Empty;
    public string ExternalReference { get; set; } = string.Empty;
}
