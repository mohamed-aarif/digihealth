using System;
using System.Linq;
using System.Threading.Tasks;
using IdentityService.Localization;
using IdentityService.Permissions;
using IdentityService.Users.Dtos;
using Microsoft.AspNetCore.Authorization;
using Volo.Abp;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Identity;

namespace IdentityService.Users;

[Authorize(IdentityServicePermissions.Profile.Default)]
public class UserProfileAppService : CrudAppService<UserProfile, UserProfileDto, Guid, UserProfilePagedAndSortedResultRequestDto, CreateUserProfileDto, UpdateUserProfileDto>,
    IUserProfileAppService
{
    private readonly IRepository<IdentityUser, Guid> _identityUserRepository;
    private readonly IdentityUserManager _identityUserManager;

    public UserProfileAppService(
        IRepository<UserProfile, Guid> repository,
        IRepository<IdentityUser, Guid> identityUserRepository,
        IdentityUserManager identityUserManager)
        : base(repository)
    {
        _identityUserRepository = identityUserRepository;
        _identityUserManager = identityUserManager;
        LocalizationResource = typeof(IdentityServiceResource);
        ObjectMapperContext = typeof(IdentityServiceApplicationModule);
    }

    public override async Task<UserProfileDto> CreateAsync(CreateUserProfileDto input)
    {
        await CheckCreatePolicyAsync();

        var user = await _identityUserRepository.GetAsync(input.Id);
        await UpdateIdentityUserAsync(
            user,
            input.UserName,
            input.Email,
            input.Salutation,
            input.ProfilePhotoUrl,
            input.Name,
            input.Surname,
            input.IsActive);
        var entity = new UserProfile(
            input.Id,
            user.TenantId,
            user.UserName,
            user.Email,
            user.GetSalutation(),
            user.GetProfilePhotoUrl(),
            user.Name,
            user.Surname,
            user.IsActive);

        await Repository.InsertAsync(entity, autoSave: true);
        return await MapToGetOutputDtoAsync(entity);
    }

    public override async Task<UserProfileDto> UpdateAsync(Guid id, UpdateUserProfileDto input)
    {
        await CheckUpdatePolicyAsync();

        var entity = await Repository.GetAsync(id);
        var user = await _identityUserRepository.GetAsync(id);

        await UpdateIdentityUserAsync(
            user,
            input.UserName,
            input.Email,
            input.Salutation,
            input.ProfilePhotoUrl,
            input.Name,
            input.Surname,
            input.IsActive);
        entity.ChangeUserName(user.UserName);
        entity.ChangeEmail(user.Email);
        entity.UpdateProfile(
            user.GetSalutation(),
            user.GetProfilePhotoUrl(),
            user.Name,
            user.Surname,
            user.IsActive);
        entity.ConcurrencyStamp = input.ConcurrencyStamp;

        await Repository.UpdateAsync(entity, autoSave: true);
        return await MapToGetOutputDtoAsync(entity);
    }

    public override async Task<PagedResultDto<UserProfileDto>> GetListAsync(UserProfilePagedAndSortedResultRequestDto input)
    {
        await CheckGetListPolicyAsync();

        var queryable = await Repository.GetQueryableAsync();

        if (input.TenantId.HasValue)
        {
            queryable = queryable.Where(x => x.TenantId == input.TenantId);
        }

        if (!input.Filter.IsNullOrWhiteSpace())
        {
            var filter = input.Filter!.ToLower();
            queryable = queryable.Where(x =>
                x.UserName.ToLower().Contains(filter)
                || x.Email.ToLower().Contains(filter)
                || (x.Name ?? string.Empty).ToLower().Contains(filter)
                || (x.Surname ?? string.Empty).ToLower().Contains(filter));
        }

        if (input.IsActive.HasValue)
        {
            queryable = queryable.Where(x => x.IsActive == input.IsActive.Value);
        }

        var totalCount = await AsyncExecuter.CountAsync(queryable);

        queryable = ApplySorting(queryable, input);
        queryable = queryable.Skip(input.SkipCount).Take(input.MaxResultCount);

        var items = await AsyncExecuter.ToListAsync(queryable);

        return new PagedResultDto<UserProfileDto>(totalCount, await MapToGetListOutputDtosAsync(items));
    }

    protected override IQueryable<UserProfile> ApplyDefaultSorting(IQueryable<UserProfile> query)
    {
        return query.OrderByDescending(x => x.CreationTime);
    }

    private async Task UpdateIdentityUserAsync(
        IdentityUser user,
        string userName,
        string email,
        string? salutation,
        string? profilePhotoUrl,
        string? name,
        string? surname,
        bool isActive)
    {
        user.SetUserName(userName);
        user.SetEmail(email, email);
        user.Name = name;
        user.Surname = surname;
        user.IsActive = isActive;
        user.SetSalutation(salutation);
        user.SetProfilePhotoUrl(profilePhotoUrl);

        var updateResult = await _identityUserManager.UpdateAsync(user);
        updateResult.CheckErrors();
    }
}
