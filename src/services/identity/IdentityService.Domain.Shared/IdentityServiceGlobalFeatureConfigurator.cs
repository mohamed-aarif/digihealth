using Volo.Abp.Threading;

namespace IdentityService;

public static class IdentityServiceGlobalFeatureConfigurator
{
    private static readonly OneTimeRunner OneTimeRunner = new();

    public static void Configure()
    {
        OneTimeRunner.Run(() => { });
    }
}
