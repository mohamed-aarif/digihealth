using System.ComponentModel.DataAnnotations;

namespace IdentityService.Doctors.Dtos;

public class UpdateDoctorDto : CreateDoctorDto
{
    [StringLength(40)]
    public string? ConcurrencyStamp { get; set; }
}
