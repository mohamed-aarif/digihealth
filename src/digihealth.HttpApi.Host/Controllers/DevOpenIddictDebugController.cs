using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using OpenIddict.Abstractions;
using Volo.Abp.AspNetCore.Mvc;

namespace digihealth.Controllers;

public class DevOpenIddictDebugController : AbpControllerBase
{
    private readonly IOpenIddictApplicationManager _applicationManager;

    public DevOpenIddictDebugController(IOpenIddictApplicationManager applicationManager)
    {
        _applicationManager = applicationManager;
    }

    [HttpGet]
    [Route("api/dev/openiddict/apps/digihealth-swagger")]
    public async Task<ActionResult<OpenIddictAppDebugDto>> GetSwaggerAppAsync()
    {
        var app = await _applicationManager.FindByClientIdAsync("digihealth_Swagger");
        if (app == null)
        {
            return NotFound();
        }

        var descriptor = new OpenIddictApplicationDescriptor();
        await _applicationManager.PopulateAsync(descriptor, app);

        var dto = new OpenIddictAppDebugDto
        {
            ClientId = descriptor.ClientId,
            DisplayName = descriptor.DisplayName,
            RedirectUris = descriptor.RedirectUris.Select(uri => uri.ToString()).ToArray(),
            PostLogoutRedirectUris = descriptor.PostLogoutRedirectUris.Select(uri => uri.ToString()).ToArray(),
            Permissions = descriptor.Permissions.ToArray()
        };

        return dto;
    }
}

public class OpenIddictAppDebugDto
{
    public string? ClientId { get; set; }

    public string? DisplayName { get; set; }

    public string[] RedirectUris { get; set; } = Array.Empty<string>();

    public string[] PostLogoutRedirectUris { get; set; } = Array.Empty<string>();

    public string[] Permissions { get; set; } = Array.Empty<string>();
}
