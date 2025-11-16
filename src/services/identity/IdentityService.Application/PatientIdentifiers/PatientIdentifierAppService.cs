using System;
using IdentityService.PatientIdentifiers.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.PatientIdentifiers;

public class PatientIdentifierAppService :
    CrudAppService<PatientIdentifier, PatientIdentifierDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientIdentifierDto>,
    IPatientIdentifierAppService
{
    public PatientIdentifierAppService(IRepository<PatientIdentifier, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override PatientIdentifier MapToEntity(CreateUpdatePatientIdentifierDto createInput)
    {
        return new PatientIdentifier(
            GuidGenerator.Create(),
            CurrentTenant.Id,
            createInput.PatientId,
            createInput.IdType,
            createInput.IdNumber,
            createInput.IssuerCountry,
            createInput.IssueDate,
            createInput.ExpiryDate,
            createInput.Notes,
            createInput.RecordId);
    }

    protected override void MapToEntity(CreateUpdatePatientIdentifierDto updateInput, PatientIdentifier entity)
    {
        entity.Update(
            updateInput.PatientId,
            updateInput.IdType,
            updateInput.IdNumber,
            updateInput.IssuerCountry,
            updateInput.IssueDate,
            updateInput.ExpiryDate,
            updateInput.Notes,
            updateInput.RecordId);
    }
}
