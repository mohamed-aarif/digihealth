using System;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.Doctors;

public class Doctor : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid UserId { get; private set; }
    public Guid? TenantId { get; private set; }
    public string? Salutation { get; private set; }
    public string? Gender { get; private set; }
    public string? Specialization { get; private set; }
    public string? RegistrationNumber { get; private set; }

    protected Doctor()
    {
        this.SetDefaultsForExtraProperties();
    }

    public Doctor(
        Guid id,
        Guid userId,
        Guid? tenantId,
        string? salutation,
        string? gender,
        string? specialization,
        string? registrationNumber) : base(id)
    {
        SetUserId(userId);
        TenantId = tenantId;
        UpdateProfile(salutation, gender, specialization, registrationNumber);
        this.SetDefaultsForExtraProperties();
    }

    public void Update(
        string? salutation,
        string? gender,
        string? specialization,
        string? registrationNumber)
    {
        UpdateProfile(salutation, gender, specialization, registrationNumber);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetUserId(Guid userId)
    {
        UserId = Check.NotNull(userId, nameof(userId));
    }

    private void UpdateProfile(string? salutation, string? gender, string? specialization, string? registrationNumber)
    {
        Salutation = salutation.IsNullOrWhiteSpace()
            ? null
            : Check.Length(salutation, nameof(salutation), DoctorConsts.MaxSalutationLength);
        Gender = gender.IsNullOrWhiteSpace()
            ? null
            : Check.Length(gender, nameof(gender), DoctorConsts.MaxGenderLength);
        Specialization = specialization.IsNullOrWhiteSpace()
            ? null
            : Check.Length(specialization, nameof(specialization), DoctorConsts.MaxSpecializationLength);
        RegistrationNumber = registrationNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(registrationNumber, nameof(registrationNumber), DoctorConsts.MaxRegistrationNumberLength);
    }
}
