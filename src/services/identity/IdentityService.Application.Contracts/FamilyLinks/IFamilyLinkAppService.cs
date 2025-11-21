using System;
using IdentityService.FamilyLinks.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.FamilyLinks;

public interface IFamilyLinkAppService :
    ICrudAppService<
        FamilyLinkDto,
        Guid,
        PagedAndSortedResultRequestDto,
        CreateUpdateFamilyLinkDto>
{
}
