using System.ComponentModel.DataAnnotations;

namespace IdentityService.Users.Dtos;

public class CreateUpdateIdentityUserAccountDto
{
    [Required]
    [StringLength(IdentityUserAccountConsts.MaxUserNameLength)]
    public string UserName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(IdentityUserAccountConsts.MaxEmailLength)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(IdentityUserAccountConsts.MaxPasswordHashLength)]
    public string PasswordHash { get; set; } = string.Empty;

    [Required]
    [StringLength(IdentityUserAccountConsts.MaxUserTypeLength)]
    public string UserType { get; set; } = string.Empty;

    public bool IsActive { get; set; } = true;

    [StringLength(IdentityUserAccountConsts.MaxPhotoStorageKeyLength)]
    public string? PhotoStorageKey { get; set; }
}
