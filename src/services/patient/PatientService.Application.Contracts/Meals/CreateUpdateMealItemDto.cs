using System;
using System.ComponentModel.DataAnnotations;

namespace PatientService.Meals;

public class CreateUpdateMealItemDto
{
    public Guid? Id { get; set; }

    [Required]
    [StringLength(256)]
    public string FoodName { get; set; } = string.Empty;

    [StringLength(64)]
    public string? PortionSize { get; set; }

    public decimal? Calories { get; set; }

    public decimal? ProteinGrams { get; set; }

    public decimal? CarbsGrams { get; set; }

    public decimal? FatsGrams { get; set; }

    public string? MetadataJson { get; set; }
}
