using System;
using System.ComponentModel.DataAnnotations;
using IdentityService.Doctors;

namespace IdentityService.Doctors.Dtos;

public class CreateUpdateDoctorDto
{
    [Required]
    public Guid IdentityUserId { get; set; }

    [Required]
    [StringLength(DoctorConsts.MaxLicenseNumberLength)]
    public string LicenseNumber { get; set; } = string.Empty;

    [Required]
    [StringLength(DoctorConsts.MaxNameLength)]
    public string FirstName { get; set; } = string.Empty;

    [Required]
    [StringLength(DoctorConsts.MaxNameLength)]
    public string LastName { get; set; } = string.Empty;

    [StringLength(DoctorConsts.MaxSpecialtyLength)]
    public string? Specialty { get; set; }
}
