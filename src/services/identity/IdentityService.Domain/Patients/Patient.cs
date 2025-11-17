using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;
using Volo.Abp.MultiTenancy;
using Volo.Abp.Timing;

namespace IdentityService.Patients;

public class Patient : AggregateRoot<Guid>, IMultiTenant, IHasCreationTime
{
    public Guid UserId { get; private set; }
    public Guid? TenantId { get; private set; }
    public string? Salutation { get; private set; }
    public DateTime? DateOfBirth { get; private set; }
    public string? Gender { get; private set; }
    public string? ResidenceCountry { get; private set; }
    public DateTime CreationTime { get; private set; }

    protected Patient()
    {
        CreationTime = Clock.Now;
    }

    public Patient(
        Guid id,
        Guid userId,
        Guid? tenantId,
        string? salutation,
        DateTime? dateOfBirth,
        string? gender,
        string? residenceCountry) : base(id)
    {
        SetUserId(userId);
        TenantId = tenantId;
        UpdateProfile(salutation, dateOfBirth, gender, residenceCountry);
        CreationTime = Clock.Now;
    }

    public void Update(string? salutation, DateTime? dateOfBirth, string? gender, string? residenceCountry)
    {
        UpdateProfile(salutation, dateOfBirth, gender, residenceCountry);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetUserId(Guid userId)
    {
        UserId = Check.NotNull(userId, nameof(userId));
    }

    private void UpdateProfile(string? salutation, DateTime? dateOfBirth, string? gender, string? residenceCountry)
    {
        Salutation = salutation.IsNullOrWhiteSpace()
            ? null
            : Check.Length(salutation, nameof(salutation), PatientConsts.MaxSalutationLength);
        DateOfBirth = dateOfBirth;
        Gender = gender.IsNullOrWhiteSpace()
            ? null
            : Check.Length(gender, nameof(gender), PatientConsts.MaxGenderLength);
        ResidenceCountry = residenceCountry.IsNullOrWhiteSpace()
            ? null
            : Check.Length(residenceCountry, nameof(residenceCountry), PatientConsts.MaxResidenceCountryLength);
    }
}
