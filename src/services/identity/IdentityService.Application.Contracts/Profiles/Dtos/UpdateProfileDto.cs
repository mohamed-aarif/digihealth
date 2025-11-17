using System.ComponentModel.DataAnnotations;
using IdentityService.Users;

namespace IdentityService.Profiles.Dtos;

public class UpdateProfileDto
{
    [StringLength(IdentityUserExtensionConsts.MaxSalutationLength)]
    public string? Salutation { get; set; }

    [StringLength(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength)]
    public string? ProfilePhotoUrl { get; set; }

    [StringLength(64)]
    public string? Name { get; set; }

    [StringLength(64)]
    public string? Surname { get; set; }
}
