using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Doctors;

public class Doctor : AggregateRoot<Guid>
{
    public Guid UserId { get; private set; }
    public string FullName { get; private set; }
    public string? Specialty { get; private set; }
    public string? RegistrationNumber { get; private set; }
    public string? ClinicName { get; private set; }
    public DateTime CreatedAt { get; private set; }

    private Doctor()
    {
        FullName = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public Doctor(
        Guid id,
        Guid userId,
        string fullName,
        string? specialty,
        string? registrationNumber,
        string? clinicName) : base(id)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(specialty, registrationNumber, clinicName);
        CreatedAt = DateTime.UtcNow;
    }

    public void SetUserId(Guid userId)
    {
        UserId = userId;
    }

    public void SetFullName(string fullName)
    {
        FullName = Check.NotNullOrWhiteSpace(fullName, nameof(fullName), DoctorConsts.MaxFullNameLength);
    }

    public void UpdateProfile(string? specialty, string? registrationNumber, string? clinicName)
    {
        Specialty = specialty.IsNullOrWhiteSpace() ? null : Check.Length(specialty, nameof(specialty), DoctorConsts.MaxSpecialtyLength);
        RegistrationNumber = registrationNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(registrationNumber, nameof(registrationNumber), DoctorConsts.MaxRegistrationNumberLength);
        ClinicName = clinicName.IsNullOrWhiteSpace() ? null : Check.Length(clinicName, nameof(clinicName), DoctorConsts.MaxClinicNameLength);
    }

    public void Update(
        Guid userId,
        string fullName,
        string? specialty,
        string? registrationNumber,
        string? clinicName)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(specialty, registrationNumber, clinicName);
    }
}
