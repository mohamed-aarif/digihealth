using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.DoctorPatientLinks.Dtos;
using IdentityService.Localization;
using IdentityService.Permissions;
using Microsoft.AspNetCore.Authorization;
using System.Linq.Dynamic.Core;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.DoctorPatientLinks;

[Authorize(DigiHealthIdentityPermissions.DoctorPatientLinks.Default)]
public class DoctorPatientLinkAppService : CrudAppService<DoctorPatientLink, DoctorPatientLinkDto, Guid, DoctorPatientLinkPagedAndSortedResultRequestDto, CreateDoctorPatientLinkDto, UpdateDoctorPatientLinkDto>, IDoctorPatientLinkAppService
{
    public DoctorPatientLinkAppService(IRepository<DoctorPatientLink, Guid> repository)
        : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(DigiHealthIdentityPermissions.DoctorPatientLinks.Create)]
    public override Task<DoctorPatientLinkDto> CreateAsync(CreateDoctorPatientLinkDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(DigiHealthIdentityPermissions.DoctorPatientLinks.Edit)]
    public override Task<DoctorPatientLinkDto> UpdateAsync(Guid id, UpdateDoctorPatientLinkDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(DigiHealthIdentityPermissions.DoctorPatientLinks.Delete)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public override async Task<PagedResultDto<DoctorPatientLinkDto>> GetListAsync(DoctorPatientLinkPagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();

        var queryable = await Repository.GetQueryableAsync();

        if (input.TenantId.HasValue)
        {
            queryable = queryable.Where(x => x.TenantId == input.TenantId);
        }

        if (input.DoctorId.HasValue)
        {
            queryable = queryable.Where(x => x.DoctorId == input.DoctorId);
        }

        if (input.PatientId.HasValue)
        {
            queryable = queryable.Where(x => x.PatientId == input.PatientId);
        }

        var totalCount = await AsyncExecuter.CountAsync(queryable);
        var items = await AsyncExecuter.ToListAsync(
            queryable
                .OrderBy(input.Sorting ?? nameof(DoctorPatientLink.CreationTime) + " DESC")
                .Skip(input.SkipCount)
                .Take(input.MaxResultCount));

        return new PagedResultDto<DoctorPatientLinkDto>(totalCount, ObjectMapper.Map<List<DoctorPatientLink>, List<DoctorPatientLinkDto>>(items));
    }

    protected override DoctorPatientLink MapToEntity(CreateDoctorPatientLinkDto createInput)
    {
        return new DoctorPatientLink(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.DoctorId,
            createInput.PatientId,
            createInput.RelationshipTypeId,
            createInput.IsPrimary,
            createInput.Notes);
    }

    protected override void MapToEntity(UpdateDoctorPatientLinkDto updateInput, DoctorPatientLink entity)
    {
        entity.Update(
            updateInput.DoctorId,
            updateInput.PatientId,
            updateInput.RelationshipTypeId,
            updateInput.IsPrimary,
            updateInput.Notes);
        entity.ChangeTenant(CurrentTenant.Id);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }
}
