using System;
using System.Collections.Generic;
using Volo.Abp.Application.Dtos;

namespace PatientService.Meals;

public class MealDto : FullAuditedEntityDto<Guid>
{
    public Guid IdentityPatientId { get; set; }
    public DateTime MealTime { get; set; }
    public string MealType { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public decimal? TotalCalories { get; set; }
    public string? MetadataJson { get; set; }
    public Guid? TenantId { get; set; }
    public List<MealItemDto> MealItems { get; set; } = new();
}
