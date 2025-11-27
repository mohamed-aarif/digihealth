using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.Doctors.Dtos;
using IdentityService.Localization;
using IdentityService.Permissions;
using IdentityService.Users;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Identity;

namespace IdentityService.Doctors;

[Authorize(IdentityServicePermissions.Doctors.Default)]
public class DoctorAppService : CrudAppService<Doctor, DoctorDto, Guid, DoctorPagedAndSortedResultRequestDto, CreateDoctorDto, UpdateDoctorDto>,
    IDoctorAppService
{
    private readonly IRepository<IdentityUser, Guid> _identityUserRepository;

    public DoctorAppService(
        IRepository<Doctor, Guid> repository,
        IRepository<IdentityUser, Guid> identityUserRepository)
        : base(repository)
    {
        _identityUserRepository = identityUserRepository;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(IdentityServicePermissions.Doctors.Manage)]
    public override Task<DoctorDto> CreateAsync(CreateDoctorDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(IdentityServicePermissions.Doctors.Manage)]
    public override Task<DoctorDto> UpdateAsync(Guid id, UpdateDoctorDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(IdentityServicePermissions.Doctors.Manage)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public override async Task<DoctorDto> GetAsync(Guid id)
    {
        await CheckGetPolicyAsync();
        var doctor = await Repository.GetAsync(id);
        var user = await _identityUserRepository.GetAsync(doctor.UserId);
        return MapDoctorDto(doctor, user);
    }

    public override async Task<PagedResultDto<DoctorDto>> GetListAsync(DoctorPagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();

        var doctorQueryable = await Repository.GetQueryableAsync();
        var userQueryable = await _identityUserRepository.GetQueryableAsync();

        var query = from doctor in doctorQueryable
                    join user in userQueryable on doctor.UserId equals user.Id
                    select new { doctor, user };

        if (!input.SpecializationFilter.IsNullOrWhiteSpace())
        {
            query = query.Where(x =>
                x.doctor.Specialization != null && x.doctor.Specialization.Contains(input.SpecializationFilter!));
        }

        if (!input.NameFilter.IsNullOrWhiteSpace())
        {
            var nameFilter = input.NameFilter!.ToLower();
            query = query.Where(x =>
                (x.user.Name ?? string.Empty).ToLower().Contains(nameFilter) ||
                (x.user.Surname ?? string.Empty).ToLower().Contains(nameFilter) ||
                x.user.UserName.ToLower().Contains(nameFilter));
        }

        if (input.TenantId.HasValue)
        {
            query = query.Where(x => x.doctor.TenantId == input.TenantId);
        }

        query = query.OrderByDescending(x => x.doctor.CreationTime);

        var totalCount = await AsyncExecuter.CountAsync(query);
        var items = await AsyncExecuter.ToListAsync(
            query.Skip(input.SkipCount).Take(input.MaxResultCount));

        var dtos = ObjectMapper.Map<List<Doctor>, List<DoctorDto>>(items.Select(i => i.doctor).ToList());
        for (var i = 0; i < items.Count; i++)
        {
            ApplyUserData(dtos[i], items[i].user);
        }

        return new PagedResultDto<DoctorDto>(totalCount, dtos);
    }

    protected override Doctor MapToEntity(CreateDoctorDto createInput)
    {
        return new Doctor(
            GuidGenerator.Create(),
            createInput.UserId,
            CurrentTenant.Id,
            createInput.Salutation,
            createInput.Gender,
            createInput.Specialization,
            createInput.RegistrationNumber);
    }

    protected override void MapToEntity(UpdateDoctorDto updateInput, Doctor entity)
    {
        entity.Update(
            updateInput.Salutation,
            updateInput.Gender,
            updateInput.Specialization,
            updateInput.RegistrationNumber);
        entity.ConcurrencyStamp = updateInput.ConcurrencyStamp;
    }

    private DoctorDto MapDoctorDto(Doctor doctor, IdentityUser user)
    {
        var dto = ObjectMapper.Map<Doctor, DoctorDto>(doctor);
        ApplyUserData(dto, user);
        return dto;
    }

    private static void ApplyUserData(DoctorDto dto, IdentityUser user)
    {
        dto.UserName = user.UserName;
        dto.Name = user.Name;
        dto.Surname = user.Surname;
        dto.ProfilePhotoUrl = user.GetProfilePhotoUrl();
    }
}
