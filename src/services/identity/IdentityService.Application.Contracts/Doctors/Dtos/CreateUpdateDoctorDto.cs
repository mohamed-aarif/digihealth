using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityService.Doctors.Dtos;

public class CreateUpdateDoctorDto
{
    [Required]
    public Guid UserId { get; set; }

    [StringLength(DoctorConsts.MaxSalutationLength)]
    public string? Salutation { get; set; }

    [StringLength(DoctorConsts.MaxGenderLength)]
    public string? Gender { get; set; }

    [StringLength(DoctorConsts.MaxSpecializationLength)]
    public string? Specialization { get; set; }

    [StringLength(DoctorConsts.MaxRegistrationNumberLength)]
    public string? RegistrationNumber { get; set; }
}
