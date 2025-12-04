using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.HealthPassports.Dtos;
using IdentityService.Localization;
using IdentityService.Permissions;
using Microsoft.AspNetCore.Authorization;
using System.Linq.Dynamic.Core;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.HealthPassports;

[Authorize(DigiHealthIdentityPermissions.HealthPassports.Default)]
public class HealthPassportAppService : CrudAppService<HealthPassport, HealthPassportDto, Guid, HealthPassportPagedAndSortedResultRequestDto, CreateHealthPassportDto, UpdateHealthPassportDto>, IHealthPassportAppService
{
    public HealthPassportAppService(IRepository<HealthPassport, Guid> repository)
        : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(DigiHealthIdentityPermissions.HealthPassports.Create)]
    public override Task<HealthPassportDto> CreateAsync(CreateHealthPassportDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(DigiHealthIdentityPermissions.HealthPassports.Edit)]
    public override Task<HealthPassportDto> UpdateAsync(Guid id, UpdateHealthPassportDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(DigiHealthIdentityPermissions.HealthPassports.Delete)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public override async Task<PagedResultDto<HealthPassportDto>> GetListAsync(HealthPassportPagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();

        var queryable = await Repository.GetQueryableAsync();

        if (input.TenantId.HasValue)
        {
            queryable = queryable.Where(x => x.TenantId == input.TenantId);
        }

        if (input.PatientId.HasValue)
        {
            queryable = queryable.Where(x => x.PatientId == input.PatientId);
        }

        if (!input.PassportType.IsNullOrWhiteSpace())
        {
            queryable = queryable.Where(x => x.PassportType == input.PassportType);
        }

        if (!input.Status.IsNullOrWhiteSpace())
        {
            queryable = queryable.Where(x => x.Status == input.Status);
        }

        var totalCount = await AsyncExecuter.CountAsync(queryable);
        var items = await AsyncExecuter.ToListAsync(
            queryable
                .OrderBy(input.Sorting ?? nameof(HealthPassport.CreationTime) + " DESC")
                .Skip(input.SkipCount)
                .Take(input.MaxResultCount));

        return new PagedResultDto<HealthPassportDto>(totalCount, ObjectMapper.Map<List<HealthPassport>, List<HealthPassportDto>>(items));
    }

    protected override HealthPassport MapToEntity(CreateHealthPassportDto createInput)
    {
        return new HealthPassport(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.PatientId,
            createInput.PassportNumber,
            createInput.PassportType,
            createInput.IssuedBy,
            createInput.IssuedAt ?? Clock.Now,
            createInput.ExpiresAt,
            createInput.Status,
            createInput.QrCodePayload,
            createInput.MetadataJson);
    }

    protected override void MapToEntity(UpdateHealthPassportDto updateInput, HealthPassport entity)
    {
        entity.UpdatePassport(
            updateInput.PassportNumber,
            updateInput.PassportType,
            updateInput.IssuedBy,
            updateInput.IssuedAt ?? entity.IssuedAt,
            updateInput.ExpiresAt,
            updateInput.Status,
            updateInput.QrCodePayload,
            updateInput.MetadataJson);
        entity.ChangeTenant(CurrentTenant.Id);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }
}
