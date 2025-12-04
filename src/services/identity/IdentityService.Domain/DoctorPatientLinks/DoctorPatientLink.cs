using System;
using System.ComponentModel.DataAnnotations.Schema;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.DoctorPatientLinks;

[Table("doctor_patient_links", Schema = "identity")]
public class DoctorPatientLink : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public Guid DoctorId { get; private set; }
    public Guid PatientId { get; private set; }
    public Guid? RelationshipTypeId { get; private set; }
    public bool IsPrimary { get; private set; }
    public string? Notes { get; private set; }

    protected DoctorPatientLink()
    {
        this.SetDefaultsForExtraProperties();
    }

    public DoctorPatientLink(
        Guid id,
        Guid? tenantId,
        Guid doctorId,
        Guid patientId,
        Guid? relationshipTypeId,
        bool isPrimary,
        string? notes) : base(id)
    {
        TenantId = tenantId;
        SetDoctorId(doctorId);
        SetPatientId(patientId);
        RelationshipTypeId = relationshipTypeId;
        UpdateDetails(isPrimary, notes);
        this.SetDefaultsForExtraProperties();
    }

    public void Update(Guid doctorId, Guid patientId, Guid? relationshipTypeId, bool isPrimary, string? notes)
    {
        SetDoctorId(doctorId);
        SetPatientId(patientId);
        RelationshipTypeId = relationshipTypeId;
        UpdateDetails(isPrimary, notes);
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }

    private void UpdateDetails(bool isPrimary, string? notes)
    {
        IsPrimary = isPrimary;
        Notes = notes.IsNullOrWhiteSpace()
            ? null
            : Check.Length(notes, nameof(notes), DoctorPatientLinkConsts.MaxNotesLength);
    }

    private void SetDoctorId(Guid doctorId)
    {
        DoctorId = Check.NotNull(doctorId, nameof(doctorId));
    }

    private void SetPatientId(Guid patientId)
    {
        PatientId = Check.NotNull(patientId, nameof(patientId));
    }
}
