using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using PatientService.Permissions;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace PatientService.PatientExternalLinks;

[Authorize(DigiHealthPatientPermissions.PatientExternalLinks.Default)]
public class PatientExternalLinkAppService : CrudAppService<
    PatientExternalLink,
    PatientExternalLinkDto,
    Guid,
    PatientExternalLinkListRequestDto,
    CreateUpdatePatientExternalLinkDto,
    CreateUpdatePatientExternalLinkDto>, IPatientExternalLinkAppService
{
    private readonly IPatientIdentityLookupAppService _identityLookupAppService;

    public PatientExternalLinkAppService(
        IRepository<PatientExternalLink, Guid> repository,
        IPatientIdentityLookupAppService identityLookupAppService) : base(repository)
    {
        _identityLookupAppService = identityLookupAppService;
        GetPolicyName = DigiHealthPatientPermissions.PatientExternalLinks.Default;
        GetListPolicyName = DigiHealthPatientPermissions.PatientExternalLinks.Default;
        CreatePolicyName = DigiHealthPatientPermissions.PatientExternalLinks.Create;
        UpdatePolicyName = DigiHealthPatientPermissions.PatientExternalLinks.Edit;
        DeletePolicyName = DigiHealthPatientPermissions.PatientExternalLinks.Delete;
    }

    public async Task<PagedResultDto<PatientExternalLinkDto>> GetBySystemAsync(string systemName, Guid? identityPatientId)
    {
        await CheckGetListPolicyAsync();
        var queryable = await Repository.GetQueryableAsync();
        var filtered = queryable.Where(x => x.SystemName == systemName && (!identityPatientId.HasValue || x.IdentityPatientId == identityPatientId));
        var list = filtered.ToList();
        return new PagedResultDto<PatientExternalLinkDto>(list.Count, ObjectMapper.Map<System.Collections.Generic.List<PatientExternalLink>, System.Collections.Generic.List<PatientExternalLinkDto>>(list));
    }

    protected override async Task<IQueryable<PatientExternalLink>> CreateFilteredQueryAsync(PatientExternalLinkListRequestDto input)
    {
        var query = await base.CreateFilteredQueryAsync(input);
        if (input.IdentityPatientId.HasValue)
        {
            query = query.Where(x => x.IdentityPatientId == input.IdentityPatientId);
        }

        if (!input.SystemName.IsNullOrWhiteSpace())
        {
            query = query.Where(x => x.SystemName == input.SystemName);
        }

        return query;
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
        entity.SetIdentityPatientId(updateInput.IdentityPatientId);
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
