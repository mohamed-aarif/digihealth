using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace PatientService.Meals;

[Table("meals", Schema = PatientServiceDbProperties.DbSchema)]
public class Meal : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
    public Guid IdentityPatientId { get; protected set; }
    public DateTime MealTime { get; protected set; }
    public string MealType { get; protected set; } = string.Empty;
    public string? Notes { get; protected set; }
    public decimal? TotalCalories { get; protected set; }
    public string? MetadataJson { get; protected set; }
    public Guid? TenantId { get; set; }

    public ICollection<MealItem> MealItems { get; protected set; }

    protected Meal()
    {
        MealItems = new List<MealItem>();
    }

    public Meal(Guid id, Guid identityPatientId, DateTime mealTime, string mealType, Guid? tenantId = null)
        : base(id)
    {
        IdentityPatientId = identityPatientId;
        MealTime = mealTime;
        MealType = mealType;
        TenantId = tenantId;
        MealItems = new List<MealItem>();
    }

    public void SetIdentityPatientId(Guid identityPatientId)
    {
        IdentityPatientId = identityPatientId;
    }

    public void SetMealDetails(DateTime mealTime, string mealType, string? notes)
    {
        MealTime = mealTime;
        MealType = mealType;
        Notes = notes;
    }

    public void SetMetadata(string? metadataJson)
    {
        MetadataJson = metadataJson;
    }

    public void SetTotalCalories(decimal? totalCalories)
    {
        TotalCalories = totalCalories;
    }

    public MealItem AddItem(Guid id, string foodName, string? portionSize, decimal? calories, decimal? proteinGrams, decimal? carbsGrams, decimal? fatsGrams, string? metadataJson)
    {
        var item = new MealItem(id, Id, foodName, portionSize, calories, proteinGrams, carbsGrams, fatsGrams, metadataJson, TenantId);
        MealItems.Add(item);
        RecalculateTotalCalories();
        return item;
    }

    public void UpdateItem(MealItem item, string foodName, string? portionSize, decimal? calories, decimal? proteinGrams, decimal? carbsGrams, decimal? fatsGrams, string? metadataJson)
    {
        item.UpdateDetails(foodName, portionSize, calories, proteinGrams, carbsGrams, fatsGrams, metadataJson);
        RecalculateTotalCalories();
    }

    public void RemoveItem(Guid itemId)
    {
        var item = MealItems.FirstOrDefault(x => x.Id == itemId);
        if (item != null)
        {
            MealItems.Remove(item);
            RecalculateTotalCalories();
        }
    }

    public void RecalculateTotalCalories()
    {
        TotalCalories = MealItems.Sum(x => x.Calories ?? 0);
    }
}
