using System;
using IdentityService.Doctors.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.Doctors;

public class DoctorAppService : CrudAppService<Doctor, DoctorDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDoctorDto>, IDoctorAppService
{
    public DoctorAppService(IRepository<Doctor, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override Doctor MapToEntity(CreateUpdateDoctorDto createInput)
    {
        return new Doctor(
            GuidGenerator.Create(),
            createInput.UserId,
            createInput.FullName,
            createInput.Specialty,
            createInput.RegistrationNumber,
            createInput.ClinicName);
    }

    protected override void MapToEntity(CreateUpdateDoctorDto updateInput, Doctor entity)
    {
        entity.Update(
            updateInput.UserId,
            updateInput.FullName,
            updateInput.Specialty,
            updateInput.RegistrationNumber,
            updateInput.ClinicName);
    }
}
