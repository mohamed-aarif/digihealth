using System.ComponentModel.DataAnnotations;

namespace IdentityService.FamilyLinks.Dtos;

public class UpdateFamilyLinkDto : CreateFamilyLinkDto
{
    [StringLength(40)]
    public string? ConcurrencyStamp { get; set; }
}
