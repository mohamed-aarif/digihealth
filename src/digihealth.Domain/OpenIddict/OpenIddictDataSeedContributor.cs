using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using JetBrains.Annotations;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Localization;
using OpenIddict.Abstractions;
using Volo.Abp;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.OpenIddict.Applications;
using Volo.Abp.OpenIddict.Scopes;
using Volo.Abp.PermissionManagement;
using Volo.Abp.Uow;

namespace digihealth.OpenIddict;

/* Creates initial data that is needed to property run the application
 * and make client-to-server communication possible.
 */
public class OpenIddictDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IConfiguration _configuration;
    private readonly IOpenIddictApplicationRepository _openIddictApplicationRepository;
    private readonly IAbpApplicationManager _applicationManager;
    private readonly IOpenIddictApplicationManager _openIddictApplicationManager;
    private readonly IOpenIddictScopeRepository _openIddictScopeRepository;
    private readonly IOpenIddictScopeManager _scopeManager;
    private readonly IPermissionDataSeeder _permissionDataSeeder;
    private readonly IStringLocalizer<OpenIddictResponse> L;

    public OpenIddictDataSeedContributor(
        IConfiguration configuration,
        IOpenIddictApplicationRepository openIddictApplicationRepository,
        IAbpApplicationManager applicationManager,
        IOpenIddictApplicationManager openIddictApplicationManager,
        IOpenIddictScopeRepository openIddictScopeRepository,
        IOpenIddictScopeManager scopeManager,
        IPermissionDataSeeder permissionDataSeeder,
        IStringLocalizer<OpenIddictResponse> l)
    {
        _configuration = configuration;
        _openIddictApplicationRepository = openIddictApplicationRepository;
        _applicationManager = applicationManager;
        _openIddictApplicationManager = openIddictApplicationManager;
        _openIddictScopeRepository = openIddictScopeRepository;
        _scopeManager = scopeManager;
        _permissionDataSeeder = permissionDataSeeder;
        L = l;
    }

    [UnitOfWork]
    public virtual async Task SeedAsync(DataSeedContext context)
    {
        await CreateScopesAsync();
        await CreateApplicationsAsync();
        await CreateSwaggerClientAsync();
    }

    private async Task CreateScopesAsync()
    {
        if (await _openIddictScopeRepository.FindByNameAsync("digihealth") == null)
        {
            await _scopeManager.CreateAsync(new OpenIddictScopeDescriptor
            {
                Name = "digihealth",
                DisplayName = "digihealth API",
                Resources = { "digihealth" }
            });
        }
    }

    private async Task CreateApplicationsAsync()
    {
        // Keep using permission strings for built-in scopes
        var commonScopes = new List<string>
        {
            OpenIddictConstants.Permissions.Scopes.Address,
            OpenIddictConstants.Permissions.Scopes.Email,
            OpenIddictConstants.Permissions.Scopes.Phone,
            OpenIddictConstants.Permissions.Scopes.Profile,
            OpenIddictConstants.Permissions.Scopes.Roles,
            "digihealth"
        };

        var configurationSection = _configuration.GetSection("OpenIddict:Applications");

        // Blazor Client
        var blazorClientId = configurationSection["digihealth_Blazor:ClientId"];
        if (!blazorClientId.IsNullOrWhiteSpace())
        {
            var blazorRootUrl = configurationSection["digihealth_Blazor:RootUrl"]?.TrimEnd('/');

            await CreateApplicationAsync(
                name: blazorClientId!,
                type: OpenIddictConstants.ClientTypes.Public,
                consentType: OpenIddictConstants.ConsentTypes.Explicit,
                displayName: "Blazor Application",
                secret: null,
                grantTypes: new List<string>
                {
                    OpenIddictConstants.GrantTypes.AuthorizationCode
                },
                scopes: commonScopes,
                redirectUris: new List<string>
                {
                    $"{blazorRootUrl}/authentication/login-callback"
                },
                clientUri: blazorRootUrl,
                postLogoutRedirectUri: $"{blazorRootUrl}/authentication/logout-callback"
            );
        }

        // MVC / backend client for server-to-server calls
        await CreateApplicationAsync(
            name: "digihealth_AbpMvcClient",
            type: OpenIddictConstants.ClientTypes.Confidential,
            consentType: OpenIddictConstants.ConsentTypes.Explicit,
            displayName: "digihealth MVC / Blazor backend client",
            secret: "digihealth_AbpMvcClient_DevSecret_123!",
            grantTypes: new List<string>
            {
                OpenIddictConstants.GrantTypes.ClientCredentials
            },
            scopes: commonScopes,
            redirectUris: null,
            clientUri: null
        );
    }

    private async Task CreateSwaggerClientAsync()
    {
        const string swaggerClientId = "digihealth_Swagger";
        var rootUrl = _configuration["App:SelfUrl"]?.TrimEnd('/');
        var patientSwaggerRootUrl = _configuration["SwaggerClients:PatientService:RootUrl"]?.TrimEnd('/')
                                   ?? "https://localhost:54516";

        if (rootUrl.IsNullOrWhiteSpace())
        {
            return;
        }

        var patientSwaggerRedirectUri = new Uri($"{patientSwaggerRootUrl}/oauth2-redirect.html");
        var patientSwaggerPostLogoutUri = new Uri($"{patientSwaggerRootUrl}/");

        var descriptor = new OpenIddictApplicationDescriptor
        {
            ClientId = swaggerClientId,
            DisplayName = "DigiHealth Swagger UI",
            ConsentType = OpenIddictConstants.ConsentTypes.Explicit,
            ClientType = OpenIddictConstants.ClientTypes.Public,
            RedirectUris =
            {
                new Uri($"{rootUrl}/swagger/oauth2-redirect.html"),
                patientSwaggerRedirectUri
            },
            Permissions =
            {
                OpenIddictConstants.Permissions.Endpoints.Authorization,
                OpenIddictConstants.Permissions.Endpoints.Token,
                OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
                OpenIddictConstants.Permissions.GrantTypes.RefreshToken,
                OpenIddictConstants.Permissions.Prefixes.Scope + OpenIddictConstants.Scopes.OpenId,
                OpenIddictConstants.Permissions.Scopes.Profile,
                OpenIddictConstants.Permissions.Scopes.Email,
                OpenIddictConstants.Permissions.Scopes.Roles,
                OpenIddictConstants.Permissions.Prefixes.Scope + OpenIddictConstants.Scopes.OfflineAccess,
                OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth"
            },
            PostLogoutRedirectUris =
            {
                patientSwaggerPostLogoutUri
            },
            Requirements =
            {
                OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange
            }
        };

        var client = await _openIddictApplicationManager.FindByClientIdAsync(swaggerClientId);
        if (client == null)
        {
            await _openIddictApplicationManager.CreateAsync(descriptor);
        }
        else
        {
            var updateDescriptor = new OpenIddictApplicationDescriptor();
            await _openIddictApplicationManager.PopulateAsync(client, updateDescriptor);

            updateDescriptor.ClientType = OpenIddictConstants.ClientTypes.Public;

            var swaggerRedirectUri = new Uri($"{rootUrl}/swagger/oauth2-redirect.html");

            if (updateDescriptor.RedirectUris.All(uri => uri != swaggerRedirectUri))
            {
                updateDescriptor.RedirectUris.Add(swaggerRedirectUri);
            }

            if (updateDescriptor.RedirectUris.All(uri => uri != patientSwaggerRedirectUri))
            {
                updateDescriptor.RedirectUris.Add(patientSwaggerRedirectUri);
            }

            if (updateDescriptor.PostLogoutRedirectUris.All(uri => uri != patientSwaggerPostLogoutUri))
            {
                updateDescriptor.PostLogoutRedirectUris.Add(patientSwaggerPostLogoutUri);
            }

            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Authorization);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Token);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.RefreshToken);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + OpenIddictConstants.Scopes.OpenId);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Scopes.Profile);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Scopes.Email);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Scopes.Roles);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + OpenIddictConstants.Scopes.OfflineAccess);
            updateDescriptor.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + "digihealth");

            updateDescriptor.Requirements.Add(OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange);

            await _openIddictApplicationManager.UpdateAsync(client, updateDescriptor);
        }
    }

    private async Task CreateApplicationAsync(
        [NotNull] string name,
        [NotNull] string type,
        [NotNull] string consentType,
        string displayName,
        string? secret,
        List<string> grantTypes,
        List<string> scopes,
        List<string>? redirectUris = null,
        string? clientUri = null,
        string? postLogoutRedirectUri = null,
        List<string>? permissions = null)
    {
        if (!string.IsNullOrEmpty(secret) &&
            string.Equals(type, OpenIddictConstants.ClientTypes.Public, StringComparison.OrdinalIgnoreCase))
        {
            throw new BusinessException(L["NoClientSecretCanBeSetForPublicApplications"]);
        }

        if (string.IsNullOrEmpty(secret) &&
            string.Equals(type, OpenIddictConstants.ClientTypes.Confidential, StringComparison.OrdinalIgnoreCase))
        {
            throw new BusinessException(L["TheClientSecretIsRequiredForConfidentialApplications"]);
        }

        var client = await _openIddictApplicationRepository.FindByClientIdAsync(name);

        var application = new AbpApplicationDescriptor
        {
            ClientId = name,
            ClientType = type,
            ClientSecret = secret,
            ConsentType = consentType,
            DisplayName = displayName,
            ClientUri = clientUri,
        };

        Check.NotNullOrEmpty(grantTypes, nameof(grantTypes));
        Check.NotNullOrEmpty(scopes, nameof(scopes));

        if (new[]
            {
                OpenIddictConstants.GrantTypes.AuthorizationCode,
                OpenIddictConstants.GrantTypes.Implicit
            }.All(grantTypes.Contains))
        {
            application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.CodeIdToken);

            if (string.Equals(type, OpenIddictConstants.ClientTypes.Public, StringComparison.OrdinalIgnoreCase))
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.CodeIdTokenToken);
                application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.CodeToken);
            }
        }

        if (redirectUris != null && redirectUris.Count > 0 ||
            !postLogoutRedirectUri.IsNullOrWhiteSpace())
        {
            application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.EndSession);
        }

        var buildInGrantTypes = new[]
        {
            OpenIddictConstants.GrantTypes.Implicit,
            OpenIddictConstants.GrantTypes.Password,
            OpenIddictConstants.GrantTypes.AuthorizationCode,
            OpenIddictConstants.GrantTypes.ClientCredentials,
            OpenIddictConstants.GrantTypes.DeviceCode,
            OpenIddictConstants.GrantTypes.RefreshToken
        };

        foreach (var grantType in grantTypes)
        {
            if (grantType == OpenIddictConstants.GrantTypes.AuthorizationCode)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode);
                application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.Code);
            }

            if (grantType == OpenIddictConstants.GrantTypes.AuthorizationCode ||
                grantType == OpenIddictConstants.GrantTypes.Implicit)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Authorization);
            }

            if (grantType == OpenIddictConstants.GrantTypes.AuthorizationCode ||
                grantType == OpenIddictConstants.GrantTypes.ClientCredentials ||
                grantType == OpenIddictConstants.GrantTypes.Password ||
                grantType == OpenIddictConstants.GrantTypes.RefreshToken ||
                grantType == OpenIddictConstants.GrantTypes.DeviceCode)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Token);
                application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Revocation);
                application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.Introspection);
            }

            if (grantType == OpenIddictConstants.GrantTypes.ClientCredentials)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.ClientCredentials);
            }

            if (grantType == OpenIddictConstants.GrantTypes.Implicit)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.Implicit);
            }

            if (grantType == OpenIddictConstants.GrantTypes.Password)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.Password);
            }

            if (grantType == OpenIddictConstants.GrantTypes.RefreshToken)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.RefreshToken);
            }

            if (grantType == OpenIddictConstants.GrantTypes.DeviceCode)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.GrantTypes.DeviceCode);
                application.Permissions.Add(OpenIddictConstants.Permissions.Endpoints.DeviceAuthorization);
            }

            if (grantType == OpenIddictConstants.GrantTypes.Implicit)
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.IdToken);
                if (string.Equals(type, OpenIddictConstants.ClientTypes.Public, StringComparison.OrdinalIgnoreCase))
                {
                    application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.IdTokenToken);
                    application.Permissions.Add(OpenIddictConstants.Permissions.ResponseTypes.Token);
                }
            }

            if (!buildInGrantTypes.Contains(grantType))
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.GrantType + grantType);
            }
        }

        var buildInScopes = new[]
        {
            OpenIddictConstants.Permissions.Scopes.Address,
            OpenIddictConstants.Permissions.Scopes.Email,
            OpenIddictConstants.Permissions.Scopes.Phone,
            OpenIddictConstants.Permissions.Scopes.Profile,
            OpenIddictConstants.Permissions.Scopes.Roles
        };

        foreach (var scope in scopes)
        {
            if (buildInScopes.Contains(scope))
            {
                application.Permissions.Add(scope);
            }
            else
            {
                application.Permissions.Add(OpenIddictConstants.Permissions.Prefixes.Scope + scope);
            }
        }

        if (redirectUris != null)
        {
            foreach (var redirectUri in redirectUris)
            {
                if (redirectUri.IsNullOrWhiteSpace())
                {
                    continue;
                }

                if (!Uri.TryCreate(redirectUri, UriKind.Absolute, out var uri) ||
                    !uri.IsWellFormedOriginalString())
                {
                    throw new BusinessException(L["InvalidRedirectUri", redirectUri]);
                }

                if (application.RedirectUris.All(x => x != uri))
                {
                    application.RedirectUris.Add(uri);
                }
            }
        }

        if (postLogoutRedirectUri != null && !postLogoutRedirectUri.IsNullOrWhiteSpace())
        {
            if (!Uri.TryCreate(postLogoutRedirectUri, UriKind.Absolute, out var uri) ||
                !uri.IsWellFormedOriginalString())
            {
                throw new BusinessException(L["InvalidPostLogoutRedirectUri", postLogoutRedirectUri]);
            }

            if (application.PostLogoutRedirectUris.All(x => x != uri))
            {
                application.PostLogoutRedirectUris.Add(uri);
            }
        }

        if (permissions != null)
        {
            await _permissionDataSeeder.SeedAsync(
                ClientPermissionValueProvider.ProviderName,
                name,
                permissions,
                null
            );
        }

        if (client == null)
        {
            await _applicationManager.CreateAsync(application);
            return;
        }

        var requiresUpdate = false;

        if (!string.Equals(client.ClientType, type, StringComparison.OrdinalIgnoreCase))
        {
            client.ClientType = type;
            requiresUpdate = true;
        }

        if (!string.Equals(client.ClientSecret, secret, StringComparison.Ordinal))
        {
            client.ClientSecret = secret;
            requiresUpdate = true;
        }

        if (!string.Equals(client.DisplayName, displayName, StringComparison.Ordinal))
        {
            client.DisplayName = displayName;
            requiresUpdate = true;
        }

        if (!string.Equals(client.ConsentType, consentType, StringComparison.OrdinalIgnoreCase))
        {
            client.ConsentType = consentType;
            requiresUpdate = true;
        }

        if (!string.Equals(client.ClientUri, clientUri, StringComparison.Ordinal))
        {
            client.ClientUri = clientUri;
            requiresUpdate = true;
        }

        if (!HasSameRedirectUris(client, application))
        {
            client.RedirectUris = JsonSerializer.Serialize(
                application.RedirectUris.Select(q => q.ToString().TrimEnd('/')));
            client.PostLogoutRedirectUris = JsonSerializer.Serialize(
                application.PostLogoutRedirectUris.Select(q => q.ToString().TrimEnd('/')));

            requiresUpdate = true;
        }

        if (!HasSameScopes(client, application))
        {
            client.Permissions = JsonSerializer.Serialize(
                application.Permissions.Select(q => q.ToString()));
            requiresUpdate = true;
        }

        if (requiresUpdate)
        {
            await _applicationManager.UpdateAsync(client.ToModel());
        }
    }

    private bool HasSameRedirectUris(OpenIddictApplication existingClient, AbpApplicationDescriptor application)
    {
        return existingClient.RedirectUris ==
               JsonSerializer.Serialize(application.RedirectUris.Select(q => q.ToString().TrimEnd('/')));
    }

    private bool HasSameScopes(OpenIddictApplication existingClient, AbpApplicationDescriptor application)
    {
        return existingClient.Permissions ==
               JsonSerializer.Serialize(application.Permissions.Select(q => q.ToString().TrimEnd('/')));
    }
}
