using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.PatientIdentifiers.Dtos;

public class PatientIdentifierDto : EntityDto<Guid>
{
    public Guid PatientId { get; set; }
    public string IdType { get; set; } = string.Empty;
    public string IdNumber { get; set; } = string.Empty;
    public string? IssuerCountry { get; set; }
    public DateTime? IssueDate { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public string? Notes { get; set; }
    public Guid? RecordId { get; set; }
    public DateTime CreatedAt { get; set; }
}
