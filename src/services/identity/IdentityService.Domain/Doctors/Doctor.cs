using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;

namespace IdentityService.Doctors;

public class Doctor : FullAuditedAggregateRoot<Guid>
{
    public Guid IdentityUserId { get; private set; }
    public string LicenseNumber { get; private set; }
    public string FirstName { get; private set; }
    public string LastName { get; private set; }
    public string? Specialty { get; private set; }

    private Doctor()
    {
        LicenseNumber = string.Empty;
        FirstName = string.Empty;
        LastName = string.Empty;
    }

    public Doctor(
        Guid id,
        Guid identityUserId,
        string licenseNumber,
        string firstName,
        string lastName,
        string? specialty) : base(id)
    {
        SetIdentityUser(identityUserId);
        SetLicenseNumber(licenseNumber);
        SetName(firstName, lastName);
        Specialty = specialty;
    }

    public void SetIdentityUser(Guid identityUserId)
    {
        IdentityUserId = identityUserId;
    }

    public void SetLicenseNumber(string licenseNumber)
    {
        LicenseNumber = Check.NotNullOrWhiteSpace(licenseNumber, nameof(licenseNumber), DoctorConsts.MaxLicenseNumberLength);
    }

    public void SetName(string firstName, string lastName)
    {
        FirstName = Check.NotNullOrWhiteSpace(firstName, nameof(firstName), DoctorConsts.MaxNameLength);
        LastName = Check.NotNullOrWhiteSpace(lastName, nameof(lastName), DoctorConsts.MaxNameLength);
    }

    public void Update(
        Guid identityUserId,
        string licenseNumber,
        string firstName,
        string lastName,
        string? specialty)
    {
        SetIdentityUser(identityUserId);
        SetLicenseNumber(licenseNumber);
        SetName(firstName, lastName);
        Specialty = specialty;
    }
}
