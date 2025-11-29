using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.Users.Dtos;

public class CreateUserProfileDto
{
    [Required]
    public Guid Id { get; set; }

    [Required]
    [StringLength(256)]
    public string UserName { get; set; } = default!;

    [Required]
    [StringLength(256)]
    public string Email { get; set; } = default!;

    [StringLength(IdentityUserExtensionConsts.MaxSalutationLength)]
    public string? Salutation { get; set; }

    [StringLength(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength)]
    public string? ProfilePhotoUrl { get; set; }

    [StringLength(IdentityUserExtensionConsts.MaxNameLength)]
    public string? Name { get; set; }

    [StringLength(IdentityUserExtensionConsts.MaxSurnameLength)]
    public string? Surname { get; set; }

    public bool IsActive { get; set; } = true;
}
