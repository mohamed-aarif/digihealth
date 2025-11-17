using IdentityService.Users;
using Microsoft.EntityFrameworkCore;
using Volo.Abp.Identity;
using Volo.Abp.ObjectExtending;
using Volo.Abp.Threading;

namespace IdentityService.EntityFrameworkCore;

public static class IdentityServiceEfCoreEntityExtensionMappings
{
    private static readonly OneTimeRunner OneTimeRunner = new();

    public static void Configure()
    {
        IdentityServiceModuleExtensionConfigurator.Configure();

        OneTimeRunner.Run(() =>
        {
            ObjectExtensionManager.Instance
                .MapEfCoreProperty<IdentityUser, string?>(
                    IdentityUserExtensionConsts.SalutationPropertyName,
                    (entityBuilder, propertyBuilder) =>
                    {
                        propertyBuilder.HasMaxLength(IdentityUserExtensionConsts.MaxSalutationLength);
                    });

            ObjectExtensionManager.Instance
                .MapEfCoreProperty<IdentityUser, string?>(
                    IdentityUserExtensionConsts.ProfilePhotoUrlPropertyName,
                    (entityBuilder, propertyBuilder) =>
                    {
                        propertyBuilder.HasMaxLength(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength);
                    });
        });
    }
}
