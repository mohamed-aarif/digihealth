using System.Threading.Tasks;
using IdentityService.Profiles.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.Profiles;

public interface IProfileAppService : IApplicationService
{
    Task<ProfileDto> GetAsync();
    Task<ProfileDto> UpdateAsync(UpdateProfileDto input);
}
