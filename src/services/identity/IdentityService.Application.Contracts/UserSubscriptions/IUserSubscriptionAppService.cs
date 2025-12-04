using System;
using System.Threading.Tasks;
using IdentityService.UserSubscriptions.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.UserSubscriptions;

public interface IUserSubscriptionAppService :
    ICrudAppService<
        UserSubscriptionDto,
        Guid,
        UserSubscriptionPagedAndSortedResultRequestDto,
        CreateUserSubscriptionDto,
        UpdateUserSubscriptionDto>
{
    Task<UserSubscriptionDto?> GetCurrentForUserAsync(Guid userId);

    Task<UserSubscriptionDto> ChangePlanAsync(Guid userSubscriptionId, Guid newPlanId);

    Task<UserSubscriptionDto> CancelAsync(Guid userSubscriptionId, string cancelledStatus, DateTime? endDate = null);
}
