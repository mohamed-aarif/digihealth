using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.PatientInsurances;

public class PatientInsurance : AggregateRoot<Guid>
{
    public Guid PatientId { get; private set; }
    public string InsurerName { get; private set; }
    public string? PolicyNumber { get; private set; }
    public string? MemberId { get; private set; }
    public string? PlanName { get; private set; }
    public string? InsurerCountry { get; private set; }
    public DateTime? IssueDate { get; private set; }
    public DateTime? ExpiryDate { get; private set; }
    public bool IsActive { get; private set; }
    public Guid? RecordId { get; private set; }
    public DateTime CreatedAt { get; private set; }

    private PatientInsurance()
    {
        InsurerName = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public PatientInsurance(
        Guid id,
        Guid patientId,
        string insurerName,
        string? policyNumber,
        string? memberId,
        string? planName,
        string? insurerCountry,
        DateTime? issueDate,
        DateTime? expiryDate,
        bool isActive,
        Guid? recordId) : base(id)
    {
        SetPatient(patientId);
        SetInsurerDetails(insurerName, policyNumber, memberId, planName, insurerCountry);
        IssueDate = issueDate;
        ExpiryDate = expiryDate;
        IsActive = isActive;
        RecordId = recordId;
        CreatedAt = DateTime.UtcNow;
    }

    public void SetPatient(Guid patientId)
    {
        PatientId = patientId;
    }

    public void SetInsurerDetails(
        string insurerName,
        string? policyNumber,
        string? memberId,
        string? planName,
        string? insurerCountry)
    {
        InsurerName = Check.NotNullOrWhiteSpace(insurerName, nameof(insurerName), PatientInsuranceConsts.MaxInsurerNameLength);
        PolicyNumber = policyNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(policyNumber, nameof(policyNumber), PatientInsuranceConsts.MaxPolicyNumberLength);
        MemberId = memberId.IsNullOrWhiteSpace()
            ? null
            : Check.Length(memberId, nameof(memberId), PatientInsuranceConsts.MaxMemberIdLength);
        PlanName = planName.IsNullOrWhiteSpace()
            ? null
            : Check.Length(planName, nameof(planName), PatientInsuranceConsts.MaxPlanNameLength);
        InsurerCountry = insurerCountry.IsNullOrWhiteSpace()
            ? null
            : Check.Length(insurerCountry, nameof(insurerCountry), PatientInsuranceConsts.MaxInsurerCountryLength);
    }

    public void Update(
        Guid patientId,
        string insurerName,
        string? policyNumber,
        string? memberId,
        string? planName,
        string? insurerCountry,
        DateTime? issueDate,
        DateTime? expiryDate,
        bool isActive,
        Guid? recordId)
    {
        SetPatient(patientId);
        SetInsurerDetails(insurerName, policyNumber, memberId, planName, insurerCountry);
        IssueDate = issueDate;
        ExpiryDate = expiryDate;
        IsActive = isActive;
        RecordId = recordId;
    }
}
