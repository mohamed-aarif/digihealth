using System.ComponentModel.DataAnnotations;
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
                            IdentityUserExtensionConsts.SalutationPropertyName,
                            property =>
                            {
                                property.Attributes.Add(new StringLengthAttribute(IdentityUserExtensionConsts.MaxSalutationLength));
                            })
                            .AddOrUpdateProperty<string?>(
                                IdentityUserExtensionConsts.ProfilePhotoUrlPropertyName,
                                property =>
                                {
                                    property.Attributes.Add(new StringLengthAttribute(IdentityUserExtensionConsts.MaxProfilePhotoUrlLength));
                                });
                    });
                });
        });
    }
}
