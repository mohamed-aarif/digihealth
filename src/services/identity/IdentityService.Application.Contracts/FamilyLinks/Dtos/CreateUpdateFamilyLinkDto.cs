using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.FamilyLinks.Dtos;

public class CreateUpdateFamilyLinkDto
{
    [Required]
    public Guid PatientId { get; set; }

    [Required]
    public Guid FamilyUserId { get; set; }

    [Required]
    [StringLength(FamilyLinkConsts.MaxRelationshipLength)]
    public string Relationship { get; set; } = default!;

    public bool IsGuardian { get; set; }
}
