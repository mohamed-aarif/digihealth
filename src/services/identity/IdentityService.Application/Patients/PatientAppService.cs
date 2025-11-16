using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityService.PatientIdentifiers;
using IdentityService.PatientIdentifiers.Dtos;
using IdentityService.PatientInsurances;
using IdentityService.PatientInsurances.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.Users;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.Patients;

public class PatientAppService : CrudAppService<Patient, PatientDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientDto>, IPatientAppService
{
    private readonly IRepository<IdentityUserAccount, Guid> _userRepository;
    private readonly IRepository<PatientIdentifier, Guid> _patientIdentifierRepository;
    private readonly IRepository<PatientInsurance, Guid> _patientInsuranceRepository;

    public PatientAppService(
        IRepository<Patient, Guid> repository,
        IRepository<IdentityUserAccount, Guid> userRepository,
        IRepository<PatientIdentifier, Guid> patientIdentifierRepository,
        IRepository<PatientInsurance, Guid> patientInsuranceRepository) : base(repository)
    {
        _userRepository = userRepository;
        _patientIdentifierRepository = patientIdentifierRepository;
        _patientInsuranceRepository = patientInsuranceRepository;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    public override async Task<PatientDto> GetAsync(Guid id)
    {
        var patient = await Repository.GetAsync(id);
        var dto = ObjectMapper.Map<Patient, PatientDto>(patient);

        await PopulatePhotoAsync(patient, dto);
        await PopulateIdentifiersAsync(patient, dto);
        await PopulateInsurancesAsync(patient, dto);

        return dto;
    }

    protected override Patient MapToEntity(CreateUpdatePatientDto createInput)
    {
        return new Patient(
            GuidGenerator.Create(),
            createInput.UserId,
            createInput.FullName,
            createInput.DateOfBirth,
            createInput.Gender,
            createInput.Salutation,
            createInput.Country,
            createInput.ResidenceCountry,
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
            updateInput.Salutation,
            updateInput.Country,
            updateInput.ResidenceCountry,
            updateInput.MobileNumber,
            updateInput.HealthVaultId);
    }

    private async Task PopulatePhotoAsync(Patient patient, PatientDto dto)
    {
        var user = await _userRepository.FirstOrDefaultAsync(x => x.Id == patient.UserId);
        dto.PhotoStorageKey = user?.PhotoStorageKey;
    }

    private async Task PopulateIdentifiersAsync(Patient patient, PatientDto dto)
    {
        var identifiers = await _patientIdentifierRepository.GetListAsync(x => x.PatientId == patient.Id);
        dto.Identifiers = ObjectMapper.Map<List<PatientIdentifier>, List<PatientIdentifierDto>>(identifiers);
    }

    private async Task PopulateInsurancesAsync(Patient patient, PatientDto dto)
    {
        var insurances = await _patientInsuranceRepository.GetListAsync(x => x.PatientId == patient.Id);
        dto.Insurances = ObjectMapper.Map<List<PatientInsurance>, List<PatientInsuranceDto>>(insurances);
    }
}
