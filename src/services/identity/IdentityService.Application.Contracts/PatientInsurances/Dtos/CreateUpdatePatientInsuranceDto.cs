using System;
using System.ComponentModel.DataAnnotations;
using IdentityService.PatientInsurances;

namespace IdentityService.PatientInsurances.Dtos;

public class CreateUpdatePatientInsuranceDto
{
    [Required]
    public Guid PatientId { get; set; }

    [Required]
    [StringLength(PatientInsuranceConsts.MaxInsurerNameLength)]
    public string InsurerName { get; set; } = string.Empty;

    [StringLength(PatientInsuranceConsts.MaxPolicyNumberLength)]
    public string? PolicyNumber { get; set; }

    [StringLength(PatientInsuranceConsts.MaxMemberIdLength)]
    public string? MemberId { get; set; }

    [StringLength(PatientInsuranceConsts.MaxPlanNameLength)]
    public string? PlanName { get; set; }

    [StringLength(PatientInsuranceConsts.MaxInsurerCountryLength)]
    public string? InsurerCountry { get; set; }

    public DateTime? IssueDate { get; set; }
    public DateTime? ExpiryDate { get; set; }

    public bool IsActive { get; set; }

    public Guid? RecordId { get; set; }
}
