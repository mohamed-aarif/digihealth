using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.Doctors.Dtos;

public class CreateUpdateDoctorDto
{
    [Required]
    public Guid UserId { get; set; }

    [Required]
    [StringLength(DoctorConsts.MaxFullNameLength)]
    public string FullName { get; set; } = string.Empty;

    [StringLength(DoctorConsts.MaxSpecialtyLength)]
    public string? Specialty { get; set; }

    [StringLength(DoctorConsts.MaxRegistrationNumberLength)]
    public string? RegistrationNumber { get; set; }

    [StringLength(DoctorConsts.MaxClinicNameLength)]
    public string? ClinicName { get; set; }
}
