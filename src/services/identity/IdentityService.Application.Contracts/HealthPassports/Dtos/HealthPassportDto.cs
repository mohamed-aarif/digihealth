using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.HealthPassports.Dtos;

public class HealthPassportDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public Guid PatientId { get; set; }
    public string? PassportNumber { get; set; }
    public string? PassportType { get; set; }
    public string? IssuedBy { get; set; }
    public DateTime IssuedAt { get; set; }
    public DateTime? ExpiresAt { get; set; }
    public string Status { get; set; } = null!;
    public string? QrCodePayload { get; set; }
    public string? MetadataJson { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
