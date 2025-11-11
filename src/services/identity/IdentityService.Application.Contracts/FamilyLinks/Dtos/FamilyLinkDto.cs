using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.FamilyLinks.Dtos;

public class FamilyLinkDto : FullAuditedEntityDto<Guid>
{
    public Guid PatientId { get; set; }
    public Guid RelatedPatientId { get; set; }
    public string Relationship { get; set; } = string.Empty;
}
