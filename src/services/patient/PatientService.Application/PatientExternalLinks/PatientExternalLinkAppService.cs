using System;
using System.Threading.Tasks;
using PatientService.Permissions;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp;

namespace PatientService.PatientExternalLinks;

public class PatientExternalLinkAppService : CrudAppService<
    PatientExternalLink,
    PatientExternalLinkDto,
    Guid,
    PagedAndSortedResultRequestDto,
    CreateUpdatePatientExternalLinkDto,
    CreateUpdatePatientExternalLinkDto>, IPatientExternalLinkAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public PatientExternalLinkAppService(
        IRepository<PatientExternalLink, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = PatientServicePermissions.PatientExternalLinks.Default;
        GetListPolicyName = PatientServicePermissions.PatientExternalLinks.Default;
        CreatePolicyName = PatientServicePermissions.PatientExternalLinks.Create;
        UpdatePolicyName = PatientServicePermissions.PatientExternalLinks.Update;
        DeletePolicyName = PatientServicePermissions.PatientExternalLinks.Delete;
    }

    public async Task<PagedResultDto<PatientExternalLinkDto>> GetBySystemAsync(string systemName, Guid? identityPatientId)
    {
        var list = await Repository.GetListAsync(
            x => x.SystemName == systemName && (!identityPatientId.HasValue || x.IdentityPatientId == identityPatientId));
        return new PagedResultDto<PatientExternalLinkDto>(list.Count, ObjectMapper.Map<System.Collections.Generic.List<PatientExternalLink>, System.Collections.Generic.List<PatientExternalLinkDto>>(list));
    }

    protected override async Task<PatientExternalLink> MapToEntityAsync(CreateUpdatePatientExternalLinkDto createInput)
    {
        await EnsureIdentityPatientExistsAsync(createInput.IdentityPatientId);
        return await base.MapToEntityAsync(createInput);
    }

    protected override async Task MapToEntityAsync(CreateUpdatePatientExternalLinkDto updateInput, PatientExternalLink entity)
    {
        await EnsureIdentityPatientExistsAsync(updateInput.IdentityPatientId);
        await base.MapToEntityAsync(updateInput, entity);
        entity.IdentityPatientId = updateInput.IdentityPatientId;
        entity.UpdateLink(updateInput.SystemName, updateInput.ExternalReference);
    }

    private async Task EnsureIdentityPatientExistsAsync(Guid identityPatientId)
    {
        if (!await _identityLookupAppService.ValidatePatientIdAsync(identityPatientId))
        {
            throw new BusinessException("PatientService:IdentityPatientNotFound")
                .WithData("IdentityPatientId", identityPatientId);
        }
    }
}
