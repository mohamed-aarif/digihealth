using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Meals;

public class MealListRequestDto : PagedAndSortedResultRequestDto
{
    public Guid IdentityPatientId { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public string? MealType { get; set; }
}
