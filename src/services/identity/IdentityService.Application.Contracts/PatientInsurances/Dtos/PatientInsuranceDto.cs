using System;
using Volo.Abp.Application.Dtos;

namespace IdentityService.PatientInsurances.Dtos;

public class PatientInsuranceDto : EntityDto<Guid>
{
    public Guid PatientId { get; set; }
    public string InsurerName { get; set; } = string.Empty;
    public string? PolicyNumber { get; set; }
    public string? MemberId { get; set; }
    public string? PlanName { get; set; }
    public string? InsurerCountry { get; set; }
    public DateTime? IssueDate { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public bool IsActive { get; set; }
    public Guid? RecordId { get; set; }
    public DateTime CreatedAt { get; set; }
}
