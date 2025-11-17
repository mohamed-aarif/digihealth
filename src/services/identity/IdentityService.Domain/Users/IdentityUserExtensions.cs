using Volo.Abp.Data;
using Volo.Abp.Identity;

namespace IdentityService.Users;

public static class IdentityUserExtensions
{
    public static string? GetSalutation(this IdentityUser user)
    {
        return user.GetProperty<string?>(IdentityUserExtensionConsts.SalutationPropertyName);
    }

    public static void SetSalutation(this IdentityUser user, string? salutation)
    {
        user.SetProperty(IdentityUserExtensionConsts.SalutationPropertyName, salutation);
    }

    public static string? GetProfilePhotoUrl(this IdentityUser user)
    {
        return user.GetProperty<string?>(IdentityUserExtensionConsts.ProfilePhotoUrlPropertyName);
    }

    public static void SetProfilePhotoUrl(this IdentityUser user, string? url)
    {
        user.SetProperty(IdentityUserExtensionConsts.ProfilePhotoUrlPropertyName, url);
    }
}
