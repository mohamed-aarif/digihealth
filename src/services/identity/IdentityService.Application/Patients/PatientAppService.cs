using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.Patients.Dtos;
using IdentityService.Localization;
using IdentityService.Permissions;
using IdentityService.Users;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Identity;

namespace IdentityService.Patients;

[Authorize(DigiHealthIdentityPermissions.Patients.Default)]
public class PatientAppService : CrudAppService<Patient, PatientDto, Guid, PatientPagedAndSortedResultRequestDto, CreatePatientDto, UpdatePatientDto>,
    IPatientAppService
{
    private readonly IRepository<IdentityUser, Guid> _identityUserRepository;

    public PatientAppService(
        IRepository<Patient, Guid> repository,
        IRepository<IdentityUser, Guid> identityUserRepository)
        : base(repository)
    {
        _identityUserRepository = identityUserRepository;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    [Authorize(DigiHealthIdentityPermissions.Patients.Create)]
    public override Task<PatientDto> CreateAsync(CreatePatientDto input)
    {
        return base.CreateAsync(input);
    }

    [Authorize(DigiHealthIdentityPermissions.Patients.Edit)]
    public override Task<PatientDto> UpdateAsync(Guid id, UpdatePatientDto input)
    {
        return base.UpdateAsync(id, input);
    }

    [Authorize(DigiHealthIdentityPermissions.Patients.Delete)]
    public override Task DeleteAsync(Guid id)
    {
        return base.DeleteAsync(id);
    }

    public override async Task<PatientDto> GetAsync(Guid id)
    {
        await CheckGetPolicyAsync();
        var patient = await Repository.GetAsync(id);
        var user = await _identityUserRepository.GetAsync(patient.UserId);
        return MapPatientDto(patient, user);
    }

    public override async Task<PagedResultDto<PatientDto>> GetListAsync(PatientPagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();

        var patientQueryable = await Repository.GetQueryableAsync();
        var userQueryable = await _identityUserRepository.GetQueryableAsync();

        var query = from patient in patientQueryable
                    join user in userQueryable on patient.UserId equals user.Id
                    select new { patient, user };

        if (input.DateOfBirth.HasValue)
        {
            query = query.Where(x => x.patient.DateOfBirth == input.DateOfBirth.Value.Date);
        }

        if (input.TenantId.HasValue)
        {
            query = query.Where(x => x.patient.TenantId == input.TenantId);
        }

        if (!input.NameFilter.IsNullOrWhiteSpace())
        {
            var nameFilter = input.NameFilter!.ToLower();
            query = query.Where(x =>
                (x.user.Name ?? string.Empty).ToLower().Contains(nameFilter) ||
                (x.user.Surname ?? string.Empty).ToLower().Contains(nameFilter) ||
                x.user.UserName.ToLower().Contains(nameFilter));
        }

        query = query.OrderByDescending(x => x.patient.CreationTime);

        var totalCount = await AsyncExecuter.CountAsync(query);
        var items = await AsyncExecuter.ToListAsync(
            query.Skip(input.SkipCount).Take(input.MaxResultCount));

        var dtos = ObjectMapper.Map<List<Patient>, List<PatientDto>>(items.Select(i => i.patient).ToList());
        for (var i = 0; i < items.Count; i++)
        {
            ApplyUserData(dtos[i], items[i].user);
        }

        return new PagedResultDto<PatientDto>(totalCount, dtos);
    }

    protected override Patient MapToEntity(CreatePatientDto createInput)
    {
        return new Patient(
            GuidGenerator.Create(),
            createInput.UserId,
            CurrentTenant.Id,
            createInput.Salutation,
            createInput.DateOfBirth,
            createInput.Gender,
            createInput.ResidenceCountry);
    }

    protected override void MapToEntity(UpdatePatientDto updateInput, Patient entity)
    {
        entity.Update(
            updateInput.Salutation,
            updateInput.DateOfBirth,
            updateInput.Gender,
            updateInput.ResidenceCountry);
        if (!updateInput.ConcurrencyStamp.IsNullOrWhiteSpace())
        {
            entity.ConcurrencyStamp = updateInput.ConcurrencyStamp!;
        }
    }

    private PatientDto MapPatientDto(Patient patient, IdentityUser user)
    {
        var dto = ObjectMapper.Map<Patient, PatientDto>(patient);
        ApplyUserData(dto, user);
        return dto;
    }

    private static void ApplyUserData(PatientDto dto, IdentityUser user)
    {
        dto.UserName = user.UserName;
        dto.Name = user.Name;
        dto.Surname = user.Surname;
        dto.ProfilePhotoUrl = user.GetProfilePhotoUrl();
    }
}
