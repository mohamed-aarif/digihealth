using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.Localization;
using IdentityService.Permissions;
using IdentityService.SubscriptionPlans.Dtos;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.SubscriptionPlans;

[Authorize(DigiHealthIdentityPermissions.SubscriptionPlans.Default)]
public class SubscriptionPlanAppService : CrudAppService<SubscriptionPlan, SubscriptionPlanDto, Guid, SubscriptionPlanPagedAndSortedResultRequestDto, CreateSubscriptionPlanDto, UpdateSubscriptionPlanDto>, ISubscriptionPlanAppService
{
    public SubscriptionPlanAppService(IRepository<SubscriptionPlan, Guid> repository)
        : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(DigiHealthIdentityPermissions.SubscriptionPlans.Create)]
    public override Task<SubscriptionPlanDto> CreateAsync(CreateSubscriptionPlanDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(DigiHealthIdentityPermissions.SubscriptionPlans.Edit)]
    public override Task<SubscriptionPlanDto> UpdateAsync(Guid id, UpdateSubscriptionPlanDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(DigiHealthIdentityPermissions.SubscriptionPlans.Delete)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public async Task<ListResultDto<SubscriptionPlanDto>> GetActivePlansAsync(Guid? tenantId = null)
    {
        await CheckGetPolicyAsync();
        var queryable = await Repository.GetQueryableAsync();

        if (tenantId.HasValue)
        {
            queryable = queryable.Where(x => x.TenantId == tenantId);
        }

        var items = await AsyncExecuter.ToListAsync(queryable.Where(x => x.IsActive).OrderBy(x => x.SortOrder));
        return new ListResultDto<SubscriptionPlanDto>(ObjectMapper.Map<List<SubscriptionPlan>, List<SubscriptionPlanDto>>(items));
    }

    protected override SubscriptionPlan MapToEntity(CreateSubscriptionPlanDto createInput)
    {
        return new SubscriptionPlan(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.Code,
            createInput.Name,
            createInput.Description,
            createInput.BillingPeriod,
            createInput.PriceAmount,
            createInput.PriceCurrency,
            createInput.IsFree,
            createInput.IsActive,
            createInput.SortOrder,
            createInput.MaxDevices,
            createInput.MaxVaultRecords,
            createInput.MaxAiMessagesPerMonth,
            createInput.MetadataJson);
    }

    protected override void MapToEntity(UpdateSubscriptionPlanDto updateInput, SubscriptionPlan entity)
    {
        entity.UpdatePlan(
            updateInput.Code,
            updateInput.Name,
            updateInput.Description,
            updateInput.BillingPeriod,
            updateInput.PriceAmount,
            updateInput.PriceCurrency,
            updateInput.IsFree,
            updateInput.IsActive,
            updateInput.SortOrder,
            updateInput.MaxDevices,
            updateInput.MaxVaultRecords,
            updateInput.MaxAiMessagesPerMonth,
            updateInput.MetadataJson);
        entity.ChangeTenant(CurrentTenant.Id);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }
}
