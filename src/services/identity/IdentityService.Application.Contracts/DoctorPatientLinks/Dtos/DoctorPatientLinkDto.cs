using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.DoctorPatientLinks.Dtos;

public class DoctorPatientLinkDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public Guid DoctorId { get; set; }
    public Guid PatientId { get; set; }
    public Guid? RelationshipTypeId { get; set; }
    public bool IsPrimary { get; set; }
    public string? Notes { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
