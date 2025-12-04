using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Dtos;

namespace IdentityService.HealthPassports.Dtos;

public class CreateHealthPassportDto : EntityDto<Guid>
{
    [Required]
    public Guid PatientId { get; set; }

    public string? PassportNumber { get; set; }

    public string? PassportType { get; set; }

    public string? IssuedBy { get; set; }

    public DateTime? IssuedAt { get; set; }

    public DateTime? ExpiresAt { get; set; }

    [Required]
    public string Status { get; set; } = null!;

    public string? QrCodePayload { get; set; }

    public string? MetadataJson { get; set; }
}
