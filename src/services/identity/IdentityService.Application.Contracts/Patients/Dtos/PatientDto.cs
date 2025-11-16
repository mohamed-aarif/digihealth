using System;
using System.Collections.Generic;
using IdentityService.PatientIdentifiers.Dtos;
using IdentityService.PatientInsurances.Dtos;
using Volo.Abp.Application.Dtos;

namespace IdentityService.Patients.Dtos;

public class PatientDto : EntityDto<Guid>
{
    public Guid UserId { get; set; }
    public string FullName { get; set; } = string.Empty;
    public DateTime? DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public string? Salutation { get; set; }
    public string? Country { get; set; }
    public string? ResidenceCountry { get; set; }
    public string? MobileNumber { get; set; }
    public string? HealthVaultId { get; set; }
    public DateTime CreatedAt { get; set; }
    public string? PhotoStorageKey { get; set; }
    public List<PatientIdentifierDto> Identifiers { get; set; } = new();
    public List<PatientInsuranceDto> Insurances { get; set; } = new();
}
