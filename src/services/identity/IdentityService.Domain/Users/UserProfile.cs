using System;
using Volo.Abp;
using Volo.Abp.Data;
using Volo.Abp.Domain.Entities;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;
using Volo.Abp.ObjectExtending;

namespace IdentityService.Users;

public class UserProfile : FullAuditedAggregateRoot<Guid>, IMultiTenant, IHasConcurrencyStamp, IHasExtraProperties
{
    public Guid? TenantId { get; private set; }
    public string UserName { get; private set; }
    public string Email { get; private set; }
    public string? Salutation { get; private set; }
    public string? ProfilePhotoUrl { get; private set; }
    public string? Name { get; private set; }
    public string? Surname { get; private set; }
    public bool IsActive { get; private set; }
    public ExtraPropertyDictionary ExtraProperties { get; protected set; } = new();
    public string? ConcurrencyStamp { get; set; }

    protected UserProfile()
    {
        this.SetDefaultsForExtraProperties();
    }

    public UserProfile(
        Guid id,
        Guid? tenantId,
        string userName,
        string email,
        string? salutation,
        string? profilePhotoUrl,
        string? name,
        string? surname,
        bool isActive = true) : base(id)
    {
        TenantId = tenantId;
        UserName = Check.NotNullOrWhiteSpace(userName, nameof(userName));
        Email = Check.NotNullOrWhiteSpace(email, nameof(email));
        UpdateProfile(salutation, profilePhotoUrl, name, surname, isActive);
        this.SetDefaultsForExtraProperties();
    }

    public void UpdateProfile(
        string? salutation,
        string? profilePhotoUrl,
        string? name,
        string? surname,
        bool isActive)
    {
        Salutation = salutation.IsNullOrWhiteSpace()
            ? null
            : Check.Length(salutation, nameof(salutation), IdentityUserExtensionConsts.MaxSalutationLength);
        ProfilePhotoUrl = profilePhotoUrl.IsNullOrWhiteSpace()
            ? null
            : Check.Length(profilePhotoUrl, nameof(profilePhotoUrl), IdentityUserExtensionConsts.MaxProfilePhotoUrlLength);
        Name = name.IsNullOrWhiteSpace()
            ? null
            : Check.Length(name, nameof(name), IdentityUserExtensionConsts.MaxNameLength);
        Surname = surname.IsNullOrWhiteSpace()
            ? null
            : Check.Length(surname, nameof(surname), IdentityUserExtensionConsts.MaxSurnameLength);
        IsActive = isActive;
    }

    public void ChangeUserName(string userName)
    {
        UserName = Check.NotNullOrWhiteSpace(userName, nameof(userName));
    }

    public void ChangeEmail(string email)
    {
        Email = Check.NotNullOrWhiteSpace(email, nameof(email));
    }

    public void ChangeTenant(Guid? tenantId)
    {
        TenantId = tenantId;
    }
}
