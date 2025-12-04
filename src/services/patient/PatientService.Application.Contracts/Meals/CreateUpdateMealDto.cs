using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Meals;

public class CreateUpdateMealDto
{
    [Required]
    public Guid IdentityPatientId { get; set; }

    [Required]
    public DateTime MealTime { get; set; }

    [Required]
    [StringLength(32)]
    public string MealType { get; set; } = string.Empty;

    public string? Notes { get; set; }

    public decimal? TotalCalories { get; set; }

    public string? MetadataJson { get; set; }

    public List<CreateUpdateMealItemDto> MealItems { get; set; } = new();
}
