using System;
using System.Linq;
using Volo.Abp;
using Volo.Abp.Domain.Entities;

namespace IdentityService.Users;

public class IdentityUserAccount : AggregateRoot<Guid>
{
    public string UserName { get; private set; }
    public string Email { get; private set; }
    public string PasswordHash { get; private set; }
    public string UserType { get; private set; }
    public bool IsActive { get; private set; }
    public DateTime CreatedAt { get; private set; }
    public string? PhotoStorageKey { get; private set; }

    private IdentityUserAccount()
    {
        UserName = string.Empty;
        Email = string.Empty;
        PasswordHash = string.Empty;
        UserType = string.Empty;
        CreatedAt = DateTime.UtcNow;
    }

    public IdentityUserAccount(
        Guid id,
        string userName,
        string email,
        string passwordHash,
        string userType,
        bool isActive,
        string? photoStorageKey = null) : base(id)
    {
        SetUserName(userName);
        SetEmail(email);
        SetPasswordHash(passwordHash);
        SetUserType(userType);
        IsActive = isActive;
        SetPhotoStorageKey(photoStorageKey);
        CreatedAt = DateTime.UtcNow;
    }

    public void SetUserName(string userName)
    {
        UserName = Check.NotNullOrWhiteSpace(userName, nameof(userName), IdentityUserAccountConsts.MaxUserNameLength);
    }

    public void SetEmail(string email)
    {
        Email = Check.NotNullOrWhiteSpace(email, nameof(email), IdentityUserAccountConsts.MaxEmailLength);
    }

    public void SetPasswordHash(string passwordHash)
    {
        PasswordHash = Check.NotNullOrWhiteSpace(passwordHash, nameof(passwordHash), IdentityUserAccountConsts.MaxPasswordHashLength);
    }

    public void SetUserType(string userType)
    {
        var normalized = Check.NotNullOrWhiteSpace(userType, nameof(userType), IdentityUserAccountConsts.MaxUserTypeLength).Trim();
        if (!IdentityUserAccountConsts.AllowedUserTypes.Contains(normalized))
        {
            throw new BusinessException(IdentityServiceErrorCodes.InvalidUserType)
                .WithData(nameof(userType), userType);
        }

        UserType = normalized;
    }

    public void SetPhotoStorageKey(string? photoStorageKey)
    {
        PhotoStorageKey = photoStorageKey.IsNullOrWhiteSpace()
            ? null
            : Check.Length(photoStorageKey, nameof(photoStorageKey), IdentityUserAccountConsts.MaxPhotoStorageKeyLength);
    }

    public void Update(string userName, string email, string passwordHash, string userType, bool isActive, string? photoStorageKey)
    {
        SetUserName(userName);
        SetEmail(email);
        SetPasswordHash(passwordHash);
        SetUserType(userType);
        IsActive = isActive;
        SetPhotoStorageKey(photoStorageKey);
    }
}
