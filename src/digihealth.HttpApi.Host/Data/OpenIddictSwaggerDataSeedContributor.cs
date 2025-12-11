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
        var redirectUri = new Uri("https://localhost:54516/oauth2-redirect.html");
        var postLogoutUri = new Uri("https://localhost:54516/");

        var existing = await _applicationManager.FindByClientIdAsync(clientId);
        if (existing == null)
        {
            var descriptor = CreateDescriptor(clientId, redirectUri, postLogoutUri);
            await _applicationManager.CreateAsync(descriptor);
            _logger.LogInformation("Created OpenIddict application {ClientId} for Swagger with redirect {RedirectUri}", clientId, redirectUri);
            return;
        }

        var descriptorToUpdate = new OpenIddictApplicationDescriptor();
        await _applicationManager.PopulateAsync(descriptorToUpdate, existing);

        var updated = EnsureSwaggerSettings(descriptorToUpdate, redirectUri, postLogoutUri);

        if (updated)
        {
            await _applicationManager.UpdateAsync(existing, descriptorToUpdate);
            _logger.LogInformation("Updated OpenIddict application {ClientId} to include PatientService Swagger redirect URIs", clientId);
        }
    }

    private static OpenIddictApplicationDescriptor CreateDescriptor(string clientId, Uri redirectUri, Uri postLogoutUri)
    {
        var descriptor = new OpenIddictApplicationDescriptor
        {
            ClientId = clientId,
            DisplayName = "DigiHealth Swagger UI",
            ConsentType = OpenIddictConstants.ConsentTypes.Explicit,
            ClientType = OpenIddictConstants.ClientTypes.Public
        };

        descriptor.RedirectUris.Add(redirectUri);
        descriptor.PostLogoutRedirectUris.Add(postLogoutUri);

        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Authorization);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Token);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.Code);
        descriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth");

        descriptor.Requirements.Add(OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange);

        return descriptor;
    }

    private static bool EnsureSwaggerSettings(OpenIddictApplicationDescriptor descriptor, Uri redirectUri, Uri postLogoutUri)
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

        hasChanges |= EnsureUri(descriptor.RedirectUris, redirectUri);
        hasChanges |= EnsureUri(descriptor.PostLogoutRedirectUris, postLogoutUri);

        var requiredPermissions = new HashSet<string>
        {
            OpenIddictConstants.Permissions.Endpoints.Authorization,
            OpenIddictConstants.Permissions.Endpoints.Token,
            OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
            OpenIddictConstants.Permissions.ResponseTypes.Code,
            OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth"
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

        if (descriptor.DisplayName != "DigiHealth Swagger UI")
        {
            descriptor.DisplayName = "DigiHealth Swagger UI";
            hasChanges = true;
        }

        return hasChanges;
    }

    private static bool EnsureUri(ICollection<Uri> collection, Uri uri)
    {
        if (collection.Any(existing => existing == uri))
        {
            return false;
        }

        collection.Add(uri);
        return true;
    }
}
