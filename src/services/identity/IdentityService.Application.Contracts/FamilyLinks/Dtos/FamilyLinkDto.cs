using System;
using System.Text.Json.Serialization;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.FamilyLinks.Dtos;

public class FamilyLinkDto : FullAuditedEntityDto<Guid>
{
    [JsonIgnore(Condition = JsonIgnoreCondition.Never)]
    public Guid? TenantId { get; set; }
    public Guid PatientId { get; set; }
    public Guid FamilyUserId { get; set; }
    public string Relationship { get; set; } = default!;
    public bool IsGuardian { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
