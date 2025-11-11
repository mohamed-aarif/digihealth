using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;

namespace IdentityService.Patients;

public class Patient : FullAuditedAggregateRoot<Guid>
{
    public Guid IdentityUserId { get; private set; }
    public string MedicalRecordNumber { get; private set; }
    public string FirstName { get; private set; }
    public string LastName { get; private set; }
    public DateTime DateOfBirth { get; private set; }
    public string? Gender { get; private set; }
    public string? PhoneNumber { get; private set; }
    public string? Email { get; private set; }
    public string? Address { get; private set; }
    public Guid? PrimaryDoctorId { get; private set; }

    private Patient()
    {
        MedicalRecordNumber = string.Empty;
        FirstName = string.Empty;
        LastName = string.Empty;
    }

    public Patient(
        Guid id,
        Guid identityUserId,
        string medicalRecordNumber,
        string firstName,
        string lastName,
        DateTime dateOfBirth,
        string? gender,
        string? phoneNumber,
        string? email,
        string? address,
        Guid? primaryDoctorId = null) : base(id)
    {
        SetIdentityUser(identityUserId);
        SetMedicalRecordNumber(medicalRecordNumber);
        SetName(firstName, lastName);
        DateOfBirth = dateOfBirth;
        Gender = gender;
        SetContact(phoneNumber, email, address);
        PrimaryDoctorId = primaryDoctorId;
    }

    public void SetIdentityUser(Guid identityUserId)
    {
        IdentityUserId = identityUserId;
    }

    public void SetMedicalRecordNumber(string medicalRecordNumber)
    {
        MedicalRecordNumber = Check.NotNullOrWhiteSpace(
            medicalRecordNumber,
            nameof(medicalRecordNumber),
            PatientConsts.MaxMedicalRecordNumberLength);
    }

    public void SetName(string firstName, string lastName)
    {
        FirstName = Check.NotNullOrWhiteSpace(firstName, nameof(firstName), PatientConsts.MaxNameLength);
        LastName = Check.NotNullOrWhiteSpace(lastName, nameof(lastName), PatientConsts.MaxNameLength);
    }

    public void SetContact(string? phoneNumber, string? email, string? address)
    {
        if (!phoneNumber.IsNullOrWhiteSpace())
        {
            Check.Length(phoneNumber, nameof(phoneNumber), PatientConsts.MaxPhoneLength);
        }

        if (!email.IsNullOrWhiteSpace())
        {
            Check.Length(email, nameof(email), PatientConsts.MaxEmailLength);
        }

        PhoneNumber = phoneNumber;
        Email = email;
        Address = address;
    }

    public void Update(
        Guid identityUserId,
        string medicalRecordNumber,
        string firstName,
        string lastName,
        DateTime dateOfBirth,
        string? gender,
        string? phoneNumber,
        string? email,
        string? address,
        Guid? primaryDoctorId)
    {
        SetIdentityUser(identityUserId);
        SetMedicalRecordNumber(medicalRecordNumber);
        SetName(firstName, lastName);
        DateOfBirth = dateOfBirth;
        Gender = gender;
        SetContact(phoneNumber, email, address);
        PrimaryDoctorId = primaryDoctorId;
    }

    public void AssignDoctor(Guid? doctorId)
    {
        PrimaryDoctorId = doctorId;
    }
}
