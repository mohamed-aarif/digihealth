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

    protected override void MapToEntity(CreateUpdateDoctorDto updateInput, Doctor entity)
    {
        entity.Update(
            updateInput.IdentityUserId,
            updateInput.LicenseNumber,
            updateInput.FirstName,
            updateInput.LastName,
            updateInput.Specialty);
    }

    protected override Doctor MapToEntity(CreateUpdateDoctorDto createInput)
    {
        return new Doctor(
            GuidGenerator.Create(),
            createInput.IdentityUserId,
            createInput.LicenseNumber,
            createInput.FirstName,
            createInput.LastName,
            createInput.Specialty);
    }
}
