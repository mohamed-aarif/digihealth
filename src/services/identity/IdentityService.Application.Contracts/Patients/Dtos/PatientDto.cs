using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.Patients.Dtos;

public class PatientDto : FullAuditedEntityDto<Guid>
{
    public Guid UserId { get; set; }
    public Guid? TenantId { get; set; }
    public string? Salutation { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public string? ResidenceCountry { get; set; }
    public string? UserName { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
