using System;
using System.ComponentModel.DataAnnotations;
using IdentityService.FamilyLinks;

namespace IdentityService.FamilyLinks.Dtos;

public class CreateUpdateFamilyLinkDto
{
    [Required]
    public Guid PatientId { get; set; }

    [Required]
    public Guid RelatedPatientId { get; set; }

    [Required]
    [StringLength(FamilyLinkConsts.MaxRelationshipLength)]
    public string Relationship { get; set; } = string.Empty;
}
