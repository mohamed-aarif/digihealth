using System;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.PatientIdentifiers;

public class PatientIdentifier : AggregateRoot<Guid>
{
    public Guid PatientId { get; private set; }
    public string IdType { get; private set; }
    public string IdNumber { get; private set; }
    public string? IssuerCountry { get; private set; }
    public DateTime? IssueDate { get; private set; }
    public DateTime? ExpiryDate { get; private set; }
    public string? Notes { get; private set; }
    public Guid? RecordId { get; private set; }
    public DateTime CreatedAt { get; private set; }

    private PatientIdentifier()
    {
        IdType = string.Empty;
        IdNumber = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public PatientIdentifier(
        Guid id,
        Guid patientId,
        string idType,
        string idNumber,
        string? issuerCountry,
        DateTime? issueDate,
        DateTime? expiryDate,
        string? notes,
        Guid? recordId) : base(id)
    {
        SetPatient(patientId);
        SetIdDetails(idType, idNumber, issuerCountry);
        IssueDate = issueDate;
        ExpiryDate = expiryDate;
        SetNotes(notes);
        RecordId = recordId;
        CreatedAt = DateTime.UtcNow;
    }

    public void SetPatient(Guid patientId)
    {
        PatientId = patientId;
    }

    public void SetIdDetails(string idType, string idNumber, string? issuerCountry)
    {
        IdType = Check.NotNullOrWhiteSpace(idType, nameof(idType), PatientIdentifierConsts.MaxIdTypeLength);
        IdNumber = Check.NotNullOrWhiteSpace(idNumber, nameof(idNumber), PatientIdentifierConsts.MaxIdNumberLength);
        IssuerCountry = issuerCountry.IsNullOrWhiteSpace()
            ? null
            : Check.Length(issuerCountry, nameof(issuerCountry), PatientIdentifierConsts.MaxIssuerCountryLength);
    }

    public void SetNotes(string? notes)
    {
        Notes = notes.IsNullOrWhiteSpace()
            ? null
            : Check.Length(notes, nameof(notes), PatientIdentifierConsts.MaxNotesLength);
    }

    public void Update(
        Guid patientId,
        string idType,
        string idNumber,
        string? issuerCountry,
        DateTime? issueDate,
        DateTime? expiryDate,
        string? notes,
        Guid? recordId)
    {
        SetPatient(patientId);
        SetIdDetails(idType, idNumber, issuerCountry);
        IssueDate = issueDate;
        ExpiryDate = expiryDate;
        SetNotes(notes);
        RecordId = recordId;
    }
}
