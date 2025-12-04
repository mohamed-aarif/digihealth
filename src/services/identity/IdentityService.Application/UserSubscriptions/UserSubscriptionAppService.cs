using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.Localization;
using IdentityService.Permissions;
using IdentityService.SubscriptionPlans;
using IdentityService.UserSubscriptions.Dtos;
using Microsoft.AspNetCore.Authorization;
using System.Linq.Dynamic.Core;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.UserSubscriptions;

[Authorize(DigiHealthIdentityPermissions.UserSubscriptions.Default)]
public class UserSubscriptionAppService : CrudAppService<UserSubscription, UserSubscriptionDto, Guid, UserSubscriptionPagedAndSortedResultRequestDto, CreateUserSubscriptionDto, UpdateUserSubscriptionDto>, IUserSubscriptionAppService
{
    private readonly IRepository<SubscriptionPlan, Guid> _subscriptionPlanRepository;

    public UserSubscriptionAppService(IRepository<UserSubscription, Guid> repository, IRepository<SubscriptionPlan, Guid> subscriptionPlanRepository)
        : base(repository)
    {
        _subscriptionPlanRepository = subscriptionPlanRepository;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(DigiHealthIdentityPermissions.UserSubscriptions.Create)]
    public override Task<UserSubscriptionDto> CreateAsync(CreateUserSubscriptionDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(DigiHealthIdentityPermissions.UserSubscriptions.Edit)]
    public override Task<UserSubscriptionDto> UpdateAsync(Guid id, UpdateUserSubscriptionDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(DigiHealthIdentityPermissions.UserSubscriptions.Delete)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public async Task<UserSubscriptionDto?> GetCurrentForUserAsync(Guid userId)
    {
        await CheckGetPolicyAsync();
        var queryable = await Repository.GetQueryableAsync();
        var now = Clock.Now;
        var current = await AsyncExecuter.FirstOrDefaultAsync(queryable
            .Where(x => x.UserId == userId && x.Status == "Active" && x.StartDate <= now && (x.EndDate == null || x.EndDate >= now))
            .OrderByDescending(x => x.StartDate));

        return current == null ? null : ObjectMapper.Map<UserSubscription, UserSubscriptionDto>(current);
    }

    public async Task<UserSubscriptionDto> ChangePlanAsync(Guid userSubscriptionId, Guid newPlanId)
    {
        await CheckUpdatePolicyAsync();
        var subscription = await Repository.GetAsync(userSubscriptionId);
        await EnsurePlanExistsAsync(newPlanId);
        subscription.ChangeSubscriptionPlan(newPlanId);
        await Repository.UpdateAsync(subscription, true);
        return ObjectMapper.Map<UserSubscription, UserSubscriptionDto>(subscription);
    }

    public async Task<UserSubscriptionDto> CancelAsync(Guid userSubscriptionId, string cancelledStatus, DateTime? endDate = null)
    {
        await CheckUpdatePolicyAsync();
        var subscription = await Repository.GetAsync(userSubscriptionId);
        subscription.Cancel(Clock.Now, cancelledStatus, endDate ?? subscription.EndDate ?? Clock.Now);
        await Repository.UpdateAsync(subscription, true);
        return ObjectMapper.Map<UserSubscription, UserSubscriptionDto>(subscription);
    }

    public override async Task<PagedResultDto<UserSubscriptionDto>> GetListAsync(UserSubscriptionPagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();
        var queryable = await Repository.GetQueryableAsync();

        if (input.TenantId.HasValue)
        {
            queryable = queryable.Where(x => x.TenantId == input.TenantId);
        }

        if (input.UserId.HasValue)
        {
            queryable = queryable.Where(x => x.UserId == input.UserId);
        }

        if (input.SubscriptionPlanId.HasValue)
        {
            queryable = queryable.Where(x => x.SubscriptionPlanId == input.SubscriptionPlanId);
        }

        if (!input.Status.IsNullOrWhiteSpace())
        {
            queryable = queryable.Where(x => x.Status == input.Status);
        }

        var totalCount = await AsyncExecuter.CountAsync(queryable);
        var items = await AsyncExecuter.ToListAsync(
            queryable
                .OrderBy(input.Sorting ?? nameof(UserSubscription.StartDate) + " DESC")
                .Skip(input.SkipCount)
                .Take(input.MaxResultCount));

        return new PagedResultDto<UserSubscriptionDto>(totalCount, ObjectMapper.Map<List<UserSubscription>, List<UserSubscriptionDto>>(items));
    }

    protected override UserSubscription MapToEntity(CreateUserSubscriptionDto createInput)
    {
        return new UserSubscription(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.UserId,
            createInput.SubscriptionPlanId,
            createInput.StartDate,
            createInput.EndDate,
            createInput.AutoRenew,
            createInput.Status,
            createInput.ExternalReference,
            createInput.PaymentGateway,
            createInput.MetadataJson,
            null);
    }

    protected override void MapToEntity(UpdateUserSubscriptionDto updateInput, UserSubscription entity)
    {
        entity.UpdateSubscription(
            updateInput.StartDate,
            updateInput.EndDate,
            updateInput.AutoRenew,
            updateInput.Status,
            updateInput.ExternalReference,
            updateInput.PaymentGateway,
            updateInput.MetadataJson,
            updateInput.CancelledAt);
        entity.ChangeSubscriptionPlan(updateInput.SubscriptionPlanId);
        entity.ChangeTenant(CurrentTenant.Id);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }

    private async Task EnsurePlanExistsAsync(Guid subscriptionPlanId)
    {
        if (!await _subscriptionPlanRepository.AnyAsync(p => p.Id == subscriptionPlanId))
        {
            throw new BusinessException("SubscriptionPlan:NotFound").WithData("SubscriptionPlanId", subscriptionPlanId);
        }
    }
}
