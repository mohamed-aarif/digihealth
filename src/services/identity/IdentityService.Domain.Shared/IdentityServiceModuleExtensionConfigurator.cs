using IdentityService.Users;
using Volo.Abp.Identity;
using Volo.Abp.ObjectExtending;
using Volo.Abp.ObjectExtending.Modularity;
using Volo.Abp.Threading;

namespace IdentityService;

public static class IdentityServiceModuleExtensionConfigurator
{
    private static readonly OneTimeRunner OneTimeRunner = new();

    public static void Configure()
    {
        OneTimeRunner.Run(() =>
        {
            ObjectExtensionManager.Instance
                .Modules()
                .ConfigureIdentity(identity =>
                {
                    identity.ConfigureUser(user =>
                    {
                        user.AddOrUpdateProperty<string?>(
                                IdentityUserExtensions.SalutationPropertyName,
                                options => options.MapEfCore(builder => builder.HasMaxLength(IdentityUserExtensionConsts.MaxSalutationLength)))
                            .AddOrUpdateProperty<string?>(
                                IdentityUserExtensions.ProfilePhotoUrlPropertyName,
                                options => options.MapEfCore(builder => builder.HasMaxLength(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength)));
                    });
                });
        });
    }
}
