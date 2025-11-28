using System.ComponentModel.DataAnnotations;

namespace IdentityService.Users.Dtos;

public class UpdateUserProfileDto : CreateUserProfileDto
{
    [StringLength(40)]
    public string? ConcurrencyStamp { get; set; }
}
