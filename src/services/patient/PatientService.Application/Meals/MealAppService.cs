using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Meals;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Repositories;

namespace PatientService.Meals;

[Authorize(DigiHealthPatientPermissions.Meals.Default)]
public class MealAppService : CrudAppService<
    Meal,
    MealDto,
    Guid,
    MealListRequestDto,
    CreateUpdateMealDto,
    CreateUpdateMealDto>, IMealAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public MealAppService(
        IRepository<Meal, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = DigiHealthPatientPermissions.Meals.Default;
        GetListPolicyName = DigiHealthPatientPermissions.Meals.Default;
        CreatePolicyName = DigiHealthPatientPermissions.Meals.Create;
        UpdatePolicyName = DigiHealthPatientPermissions.Meals.Edit;
        DeletePolicyName = DigiHealthPatientPermissions.Meals.Delete;
    }

    public async Task<ListResultDto<MealDto>> GetListForPatientAsync(MealListRequestDto input)
    {
        await CheckGetListPolicyAsync();
        var query = await CreateFilteredQueryAsync(input);
        var items = await AsyncExecuter.ToListAsync(query.OrderByDescending(x => x.MealTime));
        return new ListResultDto<MealDto>(items.Select(MapToGetOutputDto).ToList());
    }

    public async Task<MealDto> GetDetailAsync(Guid id)
    {
        var entity = await GetEntityByIdAsync(id);
        await CheckGetPolicyAsync();
        return await MapToGetOutputDtoAsync(entity);
    }

    public override async Task<MealDto> CreateAsync(CreateUpdateMealDto input)
    {
        await CheckCreatePolicyAsync();
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);

        var meal = new Meal(GuidGenerator.Create(), input.IdentityPatientId, input.MealTime, input.MealType, CurrentTenant.Id);
        meal.SetMealDetails(input.MealTime, input.MealType, input.Notes);
        meal.SetMetadata(input.MetadataJson);
        ApplyMealItems(meal, input);
        ApplyTotalCalories(input, meal);

        await Repository.InsertAsync(meal, autoSave: true);
        return await MapToGetOutputDtoAsync(meal);
    }

    public override async Task<MealDto> UpdateAsync(Guid id, CreateUpdateMealDto input)
    {
        await CheckUpdatePolicyAsync();
        var meal = await GetEntityByIdAsync(id);
        await EnsureIdentityPatientExistsAsync(input.IdentityPatientId);

        meal.SetIdentityPatientId(input.IdentityPatientId);
        meal.SetMealDetails(input.MealTime, input.MealType, input.Notes);
        meal.SetMetadata(input.MetadataJson);
        ApplyMealItems(meal, input);
        ApplyTotalCalories(input, meal);

        await Repository.UpdateAsync(meal, autoSave: true);
        return await MapToGetOutputDtoAsync(meal);
    }

    protected override async Task<IQueryable<Meal>> CreateFilteredQueryAsync(MealListRequestDto input)
    {
        var queryable = await Repository.WithDetailsAsync(x => x.MealItems);

        if (input.IdentityPatientId != Guid.Empty)
        {
            queryable = queryable.Where(x => x.IdentityPatientId == input.IdentityPatientId);
        }

        if (input.StartDate.HasValue)
        {
            queryable = queryable.Where(x => x.MealTime >= input.StartDate.Value);
        }

        if (input.EndDate.HasValue)
        {
            queryable = queryable.Where(x => x.MealTime <= input.EndDate.Value);
        }

        if (!input.MealType.IsNullOrWhiteSpace())
        {
            queryable = queryable.Where(x => x.MealType == input.MealType);
        }

        return queryable;
    }

    protected override async Task<Meal> GetEntityByIdAsync(Guid id)
    {
        var queryable = await Repository.WithDetailsAsync(x => x.MealItems);
        var entity = await AsyncExecuter.FirstOrDefaultAsync(queryable.Where(x => x.Id == id));
        if (entity == null)
        {
            throw new EntityNotFoundException(typeof(Meal), id);
        }

        return entity;
    }

    protected override Task<Meal> MapToEntityAsync(CreateUpdateMealDto createInput)
    {
        // Creation is handled in CreateAsync for full control over aggregate setup.
        throw new NotSupportedException();
    }

    protected override Task MapToEntityAsync(CreateUpdateMealDto updateInput, Meal entity)
    {
        // Updates are handled in UpdateAsync for full control over aggregate setup.
        throw new NotSupportedException();
    }

    private void ApplyMealItems(Meal meal, CreateUpdateMealDto input)
    {
        var incomingIds = input.MealItems.Select(x => x.Id).Where(x => x.HasValue).Select(x => x!.Value).ToHashSet();

        var toRemove = meal.MealItems.Where(x => !incomingIds.Contains(x.Id)).Select(x => x.Id).ToList();
        foreach (var itemId in toRemove)
        {
            meal.RemoveItem(itemId);
        }

        foreach (var itemDto in input.MealItems)
        {
            if (itemDto.Id.HasValue)
            {
                var existing = meal.MealItems.FirstOrDefault(x => x.Id == itemDto.Id.Value);
                if (existing != null)
                {
                    meal.UpdateItem(existing, itemDto.FoodName, itemDto.PortionSize, itemDto.Calories, itemDto.ProteinGrams, itemDto.CarbsGrams, itemDto.FatsGrams, itemDto.MetadataJson);
                    continue;
                }
            }

            var itemId = itemDto.Id ?? GuidGenerator.Create();
            meal.AddItem(itemId, itemDto.FoodName, itemDto.PortionSize, itemDto.Calories, itemDto.ProteinGrams, itemDto.CarbsGrams, itemDto.FatsGrams, itemDto.MetadataJson);
        }
    }

    private static void ApplyTotalCalories(CreateUpdateMealDto input, Meal meal)
    {
        if (input.TotalCalories.HasValue)
        {
            meal.SetTotalCalories(input.TotalCalories);
        }
        else
        {
            meal.RecalculateTotalCalories();
        }
    }

    private async Task EnsureIdentityPatientExistsAsync(Guid identityPatientId)
    {
        if (!await _identityLookupAppService.ValidatePatientIdAsync(identityPatientId))
        {
            throw new BusinessException("PatientService:IdentityPatientNotFound")
                .WithData("IdentityPatientId", identityPatientId);
        }
    }
}
