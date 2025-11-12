using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.FamilyLinks.Dtos;

public class FamilyLinkDto : EntityDto<Guid>
{
    public Guid PatientId { get; set; }
    public Guid FamilyUserId { get; set; }
    public string Relationship { get; set; } = string.Empty;
    public bool IsGuardian { get; set; }
    public DateTime CreatedAt { get; set; }
}
