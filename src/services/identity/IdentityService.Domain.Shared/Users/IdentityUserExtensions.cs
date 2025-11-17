using IdentityService.Users;
using Volo.Abp.Identity;

namespace IdentityService.Users;

public static class IdentityUserExtensions
{
    public const string SalutationPropertyName = "Salutation";
    public const string ProfilePhotoUrlPropertyName = "ProfilePhotoUrl";

    public static string? GetSalutation(this IdentityUser user)
    {
        return user.GetProperty<string?>(SalutationPropertyName);
    }

    public static void SetSalutation(this IdentityUser user, string? salutation)
    {
        user.SetProperty(SalutationPropertyName, salutation);
    }

    public static string? GetProfilePhotoUrl(this IdentityUser user)
    {
        return user.GetProperty<string?>(ProfilePhotoUrlPropertyName);
    }

    public static void SetProfilePhotoUrl(this IdentityUser user, string? url)
    {
        user.SetProperty(ProfilePhotoUrlPropertyName, url);
    }
}
