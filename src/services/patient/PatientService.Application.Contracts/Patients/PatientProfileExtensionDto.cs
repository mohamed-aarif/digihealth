using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Patients;

public class PatientProfileExtensionDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public string? PrimaryContactNumber { get; set; }
    public string? SecondaryContactNumber { get; set; }
    public string? Email { get; set; }
    public string? AddressLine1 { get; set; }
    public string? AddressLine2 { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? ZipCode { get; set; }
    public string? Country { get; set; }
    public string? EmergencyContactName { get; set; }
    public string? EmergencyContactNumber { get; set; }
    public string? PreferredLanguage { get; set; }
    public Guid? TenantId { get; set; }
}
