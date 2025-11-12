using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Patients;

public class Patient : AggregateRoot<Guid>
{
    public Guid UserId { get; private set; }
    public string FullName { get; private set; }
    public DateTime? DateOfBirth { get; private set; }
    public string? Gender { get; private set; }
    public string? Country { get; private set; }
    public string? MobileNumber { get; private set; }
    public string? HealthVaultId { get; private set; }
    public DateTime CreatedAt { get; private set; }

    private Patient()
    {
        FullName = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public Patient(
        Guid id,
        Guid userId,
        string fullName,
        DateTime? dateOfBirth,
        string? gender,
        string? country,
        string? mobileNumber,
        string? healthVaultId) : base(id)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(dateOfBirth, gender, country, mobileNumber, healthVaultId);
        CreatedAt = DateTime.UtcNow;
    }

    public void SetUserId(Guid userId)
    {
        UserId = userId;
    }

    public void SetFullName(string fullName)
    {
        FullName = Check.NotNullOrWhiteSpace(fullName, nameof(fullName), PatientConsts.MaxFullNameLength);
    }

    public void UpdateProfile(
        DateTime? dateOfBirth,
        string? gender,
        string? country,
        string? mobileNumber,
        string? healthVaultId)
    {
        DateOfBirth = dateOfBirth;
        Gender = gender.IsNullOrWhiteSpace() ? null : Check.Length(gender, nameof(gender), PatientConsts.MaxGenderLength);
        Country = country.IsNullOrWhiteSpace() ? null : Check.Length(country, nameof(country), PatientConsts.MaxCountryLength);
        SetMobileNumber(mobileNumber);
        SetHealthVaultId(healthVaultId);
    }

    public void SetMobileNumber(string? mobileNumber)
    {
        MobileNumber = mobileNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(mobileNumber, nameof(mobileNumber), PatientConsts.MaxMobileNumberLength);
    }

    public void SetHealthVaultId(string? healthVaultId)
    {
        HealthVaultId = healthVaultId.IsNullOrWhiteSpace()
            ? null
            : Check.Length(healthVaultId, nameof(healthVaultId), PatientConsts.MaxHealthVaultIdLength);
    }

    public void Update(
        Guid userId,
        string fullName,
        DateTime? dateOfBirth,
        string? gender,
        string? country,
        string? mobileNumber,
        string? healthVaultId)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(dateOfBirth, gender, country, mobileNumber, healthVaultId);
    }
}
