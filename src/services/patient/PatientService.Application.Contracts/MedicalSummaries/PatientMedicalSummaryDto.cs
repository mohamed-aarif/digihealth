using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.MedicalSummaries;

public class PatientMedicalSummaryDto : EntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public Guid? TenantId { get; set; }
    public string? BloodGroup { get; set; }
    public string? Allergies { get; set; }
    public string? ChronicConditions { get; set; }
    public string? Notes { get; set; }
}
