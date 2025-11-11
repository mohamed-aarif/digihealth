using System;
using IdentityService.Patients.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.Patients;

public class PatientAppService : CrudAppService<Patient, PatientDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientDto>, IPatientAppService
{
    public PatientAppService(IRepository<Patient, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override void MapToEntity(CreateUpdatePatientDto updateInput, Patient entity)
    {
        entity.Update(
            updateInput.IdentityUserId,
            updateInput.MedicalRecordNumber,
            updateInput.FirstName,
            updateInput.LastName,
            updateInput.DateOfBirth,
            updateInput.Gender,
            updateInput.PhoneNumber,
            updateInput.Email,
            updateInput.Address,
            updateInput.PrimaryDoctorId);
    }

    protected override Patient MapToEntity(CreateUpdatePatientDto createInput)
    {
        return new Patient(
            GuidGenerator.Create(),
            createInput.IdentityUserId,
            createInput.MedicalRecordNumber,
            createInput.FirstName,
            createInput.LastName,
            createInput.DateOfBirth,
            createInput.Gender,
            createInput.PhoneNumber,
            createInput.Email,
            createInput.Address,
            createInput.PrimaryDoctorId);
    }
}
