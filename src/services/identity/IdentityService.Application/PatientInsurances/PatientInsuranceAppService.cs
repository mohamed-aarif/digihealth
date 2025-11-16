using System;
using IdentityService.PatientInsurances.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.PatientInsurances;

public class PatientInsuranceAppService :
    CrudAppService<PatientInsurance, PatientInsuranceDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientInsuranceDto>,
    IPatientInsuranceAppService
{
    public PatientInsuranceAppService(IRepository<PatientInsurance, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override PatientInsurance MapToEntity(CreateUpdatePatientInsuranceDto createInput)
    {
        return new PatientInsurance(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.PatientId,
            createInput.InsurerName,
            createInput.PolicyNumber,
            createInput.MemberId,
            createInput.PlanName,
            createInput.InsurerCountry,
            createInput.IssueDate,
            createInput.ExpiryDate,
            createInput.IsActive,
            createInput.RecordId);
    }

    protected override void MapToEntity(CreateUpdatePatientInsuranceDto updateInput, PatientInsurance entity)
    {
        entity.Update(
            updateInput.PatientId,
            updateInput.InsurerName,
            updateInput.PolicyNumber,
            updateInput.MemberId,
            updateInput.PlanName,
            updateInput.InsurerCountry,
            updateInput.IssueDate,
            updateInput.ExpiryDate,
            updateInput.IsActive,
            updateInput.RecordId);
    }
}
