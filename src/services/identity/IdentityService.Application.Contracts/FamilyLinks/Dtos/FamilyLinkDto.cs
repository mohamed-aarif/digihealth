using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.FamilyLinks.Dtos;

public class FamilyLinkDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public Guid PatientId { get; set; }
    public Guid FamilyUserId { get; set; }
    public string Relationship { get; set; } = default!;
    public bool IsGuardian { get; set; }
}
