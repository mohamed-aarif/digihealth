using System;
using IdentityService.Users.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.Users;

public class IdentityUserAccountAppService : CrudAppService<IdentityUserAccount, IdentityUserAccountDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateIdentityUserAccountDto>, IIdentityUserAccountAppService
{
    public IdentityUserAccountAppService(IRepository<IdentityUserAccount, Guid> repository) : base(repository)
    {
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    protected override IdentityUserAccount MapToEntity(CreateUpdateIdentityUserAccountDto createInput)
    {
        return new IdentityUserAccount(
            GuidGenerator.Create(),
            createInput.UserName,
            createInput.Email,
            createInput.PasswordHash,
            createInput.UserType,
            createInput.IsActive,
            createInput.PhotoStorageKey);
    }

    protected override void MapToEntity(CreateUpdateIdentityUserAccountDto updateInput, IdentityUserAccount entity)
    {
        entity.Update(
            updateInput.UserName,
            updateInput.Email,
            updateInput.PasswordHash,
            updateInput.UserType,
            updateInput.IsActive,
            updateInput.PhotoStorageKey);
    }
}
