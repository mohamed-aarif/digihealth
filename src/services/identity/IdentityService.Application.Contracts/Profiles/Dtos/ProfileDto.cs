using System;

namespace IdentityService.Profiles.Dtos;

public class ProfileDto
{
    public Guid UserId { get; set; }
    public Guid? TenantId { get; set; }
    public string? UserName { get; set; }
    public string? Email { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Salutation { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    public DoctorProfileSnippetDto? DoctorProfile { get; set; }
    public PatientProfileSnippetDto? PatientProfile { get; set; }
}

public class DoctorProfileSnippetDto
{
    public Guid DoctorId { get; set; }
    public string? Specialization { get; set; }
    public string? RegistrationNumber { get; set; }
}

public class PatientProfileSnippetDto
{
    public Guid PatientId { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? ResidenceCountry { get; set; }
}
