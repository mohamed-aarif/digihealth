using System;
using IdentityService.HealthPassports.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.HealthPassports;

public interface IHealthPassportAppService :
    ICrudAppService<
        HealthPassportDto,
        Guid,
        HealthPassportPagedAndSortedResultRequestDto,
        CreateHealthPassportDto,
        UpdateHealthPassportDto>
{
}
