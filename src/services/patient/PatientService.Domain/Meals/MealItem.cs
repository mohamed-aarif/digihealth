using System;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Meals;

public class MealItem : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid MealId { get; protected set; }
    public string FoodName { get; protected set; } = string.Empty;
    public string? PortionSize { get; protected set; }
    public decimal? Calories { get; protected set; }
    public decimal? ProteinGrams { get; protected set; }
    public decimal? CarbsGrams { get; protected set; }
    public decimal? FatsGrams { get; protected set; }
    public string? MetadataJson { get; protected set; }
    public Guid? TenantId { get; set; }

    protected MealItem()
    {
    }

    public MealItem(Guid id, Guid mealId, string foodName, string? portionSize, decimal? calories, decimal? proteinGrams, decimal? carbsGrams, decimal? fatsGrams, string? metadataJson, Guid? tenantId = null)
        : base(id)
    {
        MealId = mealId;
        FoodName = foodName;
        PortionSize = portionSize;
        Calories = calories;
        ProteinGrams = proteinGrams;
        CarbsGrams = carbsGrams;
        FatsGrams = fatsGrams;
        MetadataJson = metadataJson;
        TenantId = tenantId;
    }

    public void UpdateDetails(string foodName, string? portionSize, decimal? calories, decimal? proteinGrams, decimal? carbsGrams, decimal? fatsGrams, string? metadataJson)
    {
        FoodName = foodName;
        PortionSize = portionSize;
        Calories = calories;
        ProteinGrams = proteinGrams;
        CarbsGrams = carbsGrams;
        FatsGrams = fatsGrams;
        MetadataJson = metadataJson;
    }
}
