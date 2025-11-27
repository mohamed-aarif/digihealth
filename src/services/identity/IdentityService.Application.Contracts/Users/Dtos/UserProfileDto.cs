using System;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Data;

namespace IdentityService.Users.Dtos;

public class UserProfileDto : FullAuditedEntityDto<Guid>
{
    public Guid? TenantId { get; set; }
    public string UserName { get; set; } = default!;
    public string Email { get; set; } = default!;
    public string? Salutation { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public bool IsActive { get; set; }
    public ExtraPropertyDictionary ExtraProperties { get; set; } = new();
    public string? ConcurrencyStamp { get; set; }
}
