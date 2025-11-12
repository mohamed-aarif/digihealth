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

    protected override Patient MapToEntity(CreateUpdatePatientDto createInput)
    {
        return new Patient(
            GuidGenerator.Create(),
            createInput.UserId,
            createInput.FullName,
            createInput.DateOfBirth,
            createInput.Gender,
            createInput.Country,
            createInput.MobileNumber,
            createInput.HealthVaultId);
    }

    protected override void MapToEntity(CreateUpdatePatientDto updateInput, Patient entity)
    {
        entity.Update(
            updateInput.UserId,
            updateInput.FullName,
            updateInput.DateOfBirth,
            updateInput.Gender,
            updateInput.Country,
            updateInput.MobileNumber,
            updateInput.HealthVaultId);
    }
}
