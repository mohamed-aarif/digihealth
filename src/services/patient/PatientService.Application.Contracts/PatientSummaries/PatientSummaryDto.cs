using System;
using System.Collections.Generic;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.Users.Dtos;
using PatientService.PatientExternalLinks;
using PatientService.PatientMedicalSummaries;
using PatientService.PatientProfiles;
using Volo.Abp.Application.Dtos;

namespace PatientService.PatientSummaries;

public class PatientSummaryDto : EntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }

    public PatientDto? Patient { get; set; }

    public UserProfileDto? UserProfile { get; set; }

    public PatientProfileExtensionDto? ProfileExtension { get; set; }

    public PatientMedicalSummaryDto? MedicalSummary { get; set; }

    public IReadOnlyList<PatientExternalLinkDto> ExternalLinks { get; set; } = Array.Empty<PatientExternalLinkDto>();

    public IReadOnlyList<FamilyLinkDto> FamilyLinks { get; set; } = Array.Empty<FamilyLinkDto>();
}
