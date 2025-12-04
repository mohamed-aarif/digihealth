using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityService.SubscriptionPlans.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.SubscriptionPlans;

public interface ISubscriptionPlanAppService :
    ICrudAppService<
        SubscriptionPlanDto,
        Guid,
        SubscriptionPlanPagedAndSortedResultRequestDto,
        CreateSubscriptionPlanDto,
        UpdateSubscriptionPlanDto>
{
    Task<ListResultDto<SubscriptionPlanDto>> GetActivePlansAsync(Guid? tenantId = null);
}
