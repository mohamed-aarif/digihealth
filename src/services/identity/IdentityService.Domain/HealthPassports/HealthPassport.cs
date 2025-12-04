using System;
using System.ComponentModel.DataAnnotations.Schema;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.HealthPassports;

[Table("health_passports", Schema = "identity")]
public class HealthPassport : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public Guid PatientId { get; private set; }
    public string? PassportNumber { get; private set; }
    public string? PassportType { get; private set; }
    public string? IssuedBy { get; private set; }
    public DateTime IssuedAt { get; private set; }
    public DateTime? ExpiresAt { get; private set; }
    public string Status { get; private set; } = null!;
    public string? QrCodePayload { get; private set; }
    public string? MetadataJson { get; private set; }

    protected HealthPassport()
    {
        this.SetDefaultsForExtraProperties();
    }

    public HealthPassport(
        Guid id,
        Guid? tenantId,
        Guid patientId,
        string? passportNumber,
        string? passportType,
        string? issuedBy,
        DateTime issuedAt,
        DateTime? expiresAt,
        string status,
        string? qrCodePayload,
        string? metadataJson) : base(id)
    {
        TenantId = tenantId;
        SetPatientId(patientId);
        UpdatePassport(passportNumber, passportType, issuedBy, issuedAt, expiresAt, status, qrCodePayload, metadataJson);
        this.SetDefaultsForExtraProperties();
    }

    public void UpdatePassport(
        string? passportNumber,
        string? passportType,
        string? issuedBy,
        DateTime issuedAt,
        DateTime? expiresAt,
        string status,
        string? qrCodePayload,
        string? metadataJson)
    {
        PassportNumber = passportNumber.IsNullOrWhiteSpace()
            ? null
            : Check.Length(passportNumber, nameof(passportNumber), HealthPassportConsts.MaxPassportNumberLength);
        PassportType = passportType.IsNullOrWhiteSpace()
            ? null
            : Check.Length(passportType, nameof(passportType), HealthPassportConsts.MaxPassportTypeLength);
        IssuedBy = issuedBy.IsNullOrWhiteSpace()
            ? null
            : Check.Length(issuedBy, nameof(issuedBy), HealthPassportConsts.MaxIssuedByLength);
        IssuedAt = issuedAt;
        ExpiresAt = expiresAt;
        Status = Check.Length(Check.NotNullOrWhiteSpace(status, nameof(status)), nameof(status), HealthPassportConsts.MaxStatusLength);
        QrCodePayload = qrCodePayload;
        MetadataJson = metadataJson;
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void SetPatientId(Guid patientId)
    {
        PatientId = Check.NotNull(patientId, nameof(patientId));
    }
}
