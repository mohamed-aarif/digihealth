using System;
using Volo.Abp.Application.Dtos;

namespace PatientService.Meals;

public class MealItemDto : FullAuditedEntityDto<Guid>
{
    public Guid MealId { get; set; }
    public string FoodName { get; set; } = string.Empty;
    public string? PortionSize { get; set; }
    public decimal? Calories { get; set; }
    public decimal? ProteinGrams { get; set; }
    public decimal? CarbsGrams { get; set; }
    public decimal? FatsGrams { get; set; }
    public string? MetadataJson { get; set; }
    public Guid? TenantId { get; set; }
}
