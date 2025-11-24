using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Dtos.MedicalSummaries;

public class PatientMedicalSummaryDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public string? BloodGroup { get; set; }
    public string? Allergies { get; set; }
    public string? ChronicConditions { get; set; }
    public string? Notes { get; set; }
}
