using System.Threading.Tasks;
using IdentityService.Controllers;
using IdentityService.Profiles;
using IdentityService.Profiles.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace IdentityService.Controllers.Profile;

[Route("api/identity-service/profile")]
public class ProfileController : IdentityServiceController
{
    private readonly IProfileAppService _profileAppService;

    public ProfileController(IProfileAppService profileAppService)
    {
        _profileAppService = profileAppService;
    }

    [HttpGet]
    public Task<ProfileDto> GetAsync()
    {
        return _profileAppService.GetAsync();
    }

    [HttpPut]
    public Task<ProfileDto> UpdateAsync([FromBody] UpdateProfileDto input)
    {
        return _profileAppService.UpdateAsync(input);
    }
}
