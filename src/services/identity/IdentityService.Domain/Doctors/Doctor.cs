using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Doctors;

public class Doctor : AggregateRoot<Guid>
{
    public Guid UserId { get; private set; }
    public string FullName { get; private set; }
    public string? Salutation { get; private set; }
    public string? Gender { get; private set; }
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
        string? salutation,
        string? gender,
        string? specialty,
        string? registrationNumber,
        string? clinicName) : base(id)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(salutation, gender, specialty, registrationNumber, clinicName);
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

    public void UpdateProfile(string? salutation, string? gender, string? specialty, string? registrationNumber, string? clinicName)
    {
        Salutation = salutation.IsNullOrWhiteSpace() ? null : Check.Length(salutation, nameof(salutation), DoctorConsts.MaxSalutationLength);
        Gender = gender.IsNullOrWhiteSpace() ? null : Check.Length(gender, nameof(gender), DoctorConsts.MaxGenderLength);
        Specialty = specialty.IsNullOrWhiteSpace() ? null : Check.Length(specialty, nameof(specialty), DoctorConsts.MaxSpecialtyLength);
        RegistrationNumber = registrationNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(registrationNumber, nameof(registrationNumber), DoctorConsts.MaxRegistrationNumberLength);
        ClinicName = clinicName.IsNullOrWhiteSpace() ? null : Check.Length(clinicName, nameof(clinicName), DoctorConsts.MaxClinicNameLength);
    }

    public void Update(
        Guid userId,
        string fullName,
        string? salutation,
        string? gender,
        string? specialty,
        string? registrationNumber,
        string? clinicName)
    {
        SetUserId(userId);
        SetFullName(fullName);
        UpdateProfile(salutation, gender, specialty, registrationNumber, clinicName);
    }
}
