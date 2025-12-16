using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using OpenIddict.Abstractions;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;

namespace digihealth.Data;

public class OpenIddictSwaggerDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IOpenIddictApplicationManager _applicationManager;
    private readonly ILogger<OpenIddictSwaggerDataSeedContributor> _logger;

    public OpenIddictSwaggerDataSeedContributor(
        IOpenIddictApplicationManager applicationManager,
        ILogger<OpenIddictSwaggerDataSeedContributor> logger)
    {
        _applicationManager = applicationManager;
        _logger = logger;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        await CreateOrUpdateSwaggerClientAsync();
    }

    private async Task CreateOrUpdateSwaggerClientAsync()
    {
        const string clientId = "digihealth_Swagger";

        // ✅ All Swagger redirect URIs that should be valid for this client
        var redirectUris = new[]
        {
            new Uri("https://localhost:44322/swagger/oauth2-redirect.html"), // digihealth.HttpApi.Host Swagger
            new Uri("https://localhost:54516/swagger/oauth2-redirect.html"), // PatientService Swagger
            new Uri("https://localhost:5005/swagger/oauth2-redirect.html"),  // ConfigurationService Swagger
            new Uri("https://localhost:44385/swagger/oauth2-redirect.html")  // IdentityService Swagger
        };

        var postLogoutUris = new[]
        {
            new Uri("https://localhost:44322/"),
            new Uri("https://localhost:54516/"),
            new Uri("https://localhost:5005/"),
            new Uri("https://localhost:44385/")
        };

        var existing = await _applicationManager.FindByClientIdAsync(clientId);
        if (existing == null)
        {
            var descriptor = CreateDescriptor(clientId, redirectUris, postLogoutUris);
            await _applicationManager.CreateAsync(descriptor);

            _logger.LogInformation(
                "Created OpenIddict application {ClientId} for Swagger with redirect URIs: {RedirectUris}",
                clientId,
                string.Join(", ", redirectUris.Select(x => x.ToString()))
            );

            return;
        }

        var descriptorToUpdate = new OpenIddictApplicationDescriptor();
        await _applicationManager.PopulateAsync(descriptorToUpdate, existing);

        var updated = EnsureSwaggerSettings(descriptorToUpdate, redirectUris, postLogoutUris);

        if (updated)
        {
            await _applicationManager.UpdateAsync(existing, descriptorToUpdate);
            _logger.LogInformation(
                "Updated OpenIddict application {ClientId} to include Swagger redirect URIs: {RedirectUris}",
                clientId,
                string.Join(", ", redirectUris.Select(x => x.ToString()))
            );
        }
    }

    private static OpenIddictApplicationDescriptor CreateDescriptor(
        string clientId,
        IEnumerable<Uri> redirectUris,
        IEnumerable<Uri> postLogoutUris)
    {
        var descriptor = new OpenIddictApplicationDescriptor
        {
            ClientId = clientId,
            DisplayName = "DigiHealth Swagger UI",
            ConsentType = OpenIddictConstants.ConsentTypes.Explicit,
            ClientType = OpenIddictConstants.ClientTypes.Public
        };

        descriptor.ClientSecret = null;

        foreach (var uri in redirectUris)
        {
            descriptor.RedirectUris.Add(uri);
        }

        foreach (var uri in postLogoutUris)
        {
            descriptor.PostLogoutRedirectUris.Add(uri);
        }

        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Authorization);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Token);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.RefreshToken);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.Code);

        // scopes
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth");
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "openid");
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "profile");
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "email");
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "phone");
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "roles");

        descriptor.Requirements.Add(OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange);

        return descriptor;
    }

    private static bool EnsureSwaggerSettings(
        OpenIddictApplicationDescriptor descriptor,
        IEnumerable<Uri> redirectUris,
        IEnumerable<Uri> postLogoutUris)
    {
        var hasChanges = false;

        if (descriptor.ClientType != OpenIddictConstants.ClientTypes.Public)
        {
            descriptor.ClientType = OpenIddictConstants.ClientTypes.Public;
            hasChanges = true;
        }

        if (descriptor.ConsentType != OpenIddictConstants.ConsentTypes.Explicit)
        {
            descriptor.ConsentType = OpenIddictConstants.ConsentTypes.Explicit;
            hasChanges = true;
        }

        // Ensure we have only the expected redirect URIs
        if (!HasExactUris(descriptor.RedirectUris, redirectUris))
        {
            descriptor.RedirectUris.Clear();
            foreach (var uri in redirectUris)
            {
                descriptor.RedirectUris.Add(uri);
            }

            hasChanges = true;
        }

        // Ensure post-logout URIs
        if (!HasExactUris(descriptor.PostLogoutRedirectUris, postLogoutUris))
        {
            descriptor.PostLogoutRedirectUris.Clear();
            foreach (var uri in postLogoutUris)
            {
                descriptor.PostLogoutRedirectUris.Add(uri);
            }

            hasChanges = true;
        }

        var requiredPermissions = new HashSet<string>
        {
            OpenIddictConstants.Permissions.Endpoints.Authorization,
            OpenIddictConstants.Permissions.Endpoints.Token,
            OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
            OpenIddictConstants.Permissions.GrantTypes.RefreshToken,
            OpenIddictConstants.Permissions.ResponseTypes.Code,
            OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth",
            OpenIddictConstants.Permissions.Prefixes.Scope + "openid",
            OpenIddictConstants.Permissions.Prefixes.Scope + "profile",
            OpenIddictConstants.Permissions.Prefixes.Scope + "email",
            OpenIddictConstants.Permissions.Prefixes.Scope + "phone",
            OpenIddictConstants.Permissions.Prefixes.Scope + "roles"
        };

        foreach (var permission in requiredPermissions)
        {
            if (!descriptor.Permissions.Contains(permission))
            {
                descriptor.Permissions.Add(permission);
                hasChanges = true;
            }
        }

        if (!descriptor.Requirements.Contains(OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange))
        {
            descriptor.Requirements.Add(OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange);
            hasChanges = true;
        }

        if (descriptor.ClientSecret != null)
        {
            descriptor.ClientSecret = null;
            hasChanges = true;
        }

        if (descriptor.DisplayName != "DigiHealth Swagger UI")
        {
            descriptor.DisplayName = "DigiHealth Swagger UI";
            hasChanges = true;
        }

        return hasChanges;
    }

    private static bool HasExactUris(ICollection<Uri> existingUris, IEnumerable<Uri> expectedUris)
    {
        var existingSet = new HashSet<Uri>(existingUris);
        var expectedSet = new HashSet<Uri>(expectedUris);

        return existingSet.SetEquals(expectedSet);
    }
}
