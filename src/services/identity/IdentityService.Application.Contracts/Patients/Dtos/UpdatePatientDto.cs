using System.ComponentModel.DataAnnotations;

namespace IdentityService.Patients.Dtos;

public class UpdatePatientDto : CreatePatientDto
{
    [StringLength(40)]
    public string? ConcurrencyStamp { get; set; }
}
