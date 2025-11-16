using System.Collections.Generic;

namespace IdentityService.Users;

public static class IdentityUserAccountConsts
{
    public const int MaxUserNameLength = 64;
    public const int MaxEmailLength = 256;
    public const int MaxPasswordHashLength = 256;
    public const int MaxUserTypeLength = 20;
    public const int MaxPhotoStorageKeyLength = 256;

    public static IReadOnlyList<string> AllowedUserTypes { get; } = new[]
    {
        IdentityUserTypes.Patient,
        IdentityUserTypes.Doctor,
        IdentityUserTypes.Family
    };
}
