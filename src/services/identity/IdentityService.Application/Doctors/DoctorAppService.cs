using System;
using System.Threading.Tasks;
using IdentityService.Doctors.Dtos;
using IdentityService.Users;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.Doctors;

public class DoctorAppService : CrudAppService<Doctor, DoctorDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDoctorDto>, IDoctorAppService
{
    private readonly IRepository<IdentityUserAccount, Guid> _userRepository;

    public DoctorAppService(
        IRepository<Doctor, Guid> repository,
        IRepository<IdentityUserAccount, Guid> userRepository) : base(repository)
    {
        _userRepository = userRepository;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    public override async Task<DoctorDto> GetAsync(Guid id)
    {
        var doctor = await Repository.GetAsync(id);
        var dto = ObjectMapper.Map<Doctor, DoctorDto>(doctor);

        await PopulatePhotoAsync(doctor, dto);

        return dto;
    }

    protected override Doctor MapToEntity(CreateUpdateDoctorDto createInput)
    {
        return new Doctor(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.UserId,
            createInput.FullName,
            createInput.Salutation,
            createInput.Gender,
            createInput.Specialty,
            createInput.RegistrationNumber,
            createInput.ClinicName);
    }

    protected override void MapToEntity(CreateUpdateDoctorDto updateInput, Doctor entity)
    {
        entity.Update(
            updateInput.UserId,
            updateInput.FullName,
            updateInput.Salutation,
            updateInput.Gender,
            updateInput.Specialty,
            updateInput.RegistrationNumber,
            updateInput.ClinicName);
    }

    private async Task PopulatePhotoAsync(Doctor doctor, DoctorDto dto)
    {
        var user = await _userRepository.FirstOrDefaultAsync(x => x.Id == doctor.UserId);
        dto.PhotoStorageKey = user?.PhotoStorageKey;
    }
}
