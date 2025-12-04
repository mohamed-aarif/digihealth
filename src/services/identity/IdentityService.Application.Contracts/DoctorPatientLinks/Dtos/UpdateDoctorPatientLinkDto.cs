using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Dtos;

namespace IdentityService.DoctorPatientLinks.Dtos;

public class UpdateDoctorPatientLinkDto : EntityDto<Guid>
{
    [Required]
    public Guid DoctorId { get; set; }

    [Required]
    public Guid PatientId { get; set; }

    public Guid? RelationshipTypeId { get; set; }

    public bool IsPrimary { get; set; }

    public string? Notes { get; set; }

    public string? ConcurrencyStamp { get; set; }
}
