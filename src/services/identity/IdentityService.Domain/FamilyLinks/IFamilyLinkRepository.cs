using System;
using Volo.Abp.Domain.Repositories;

namespace IdentityService.FamilyLinks;

public interface IFamilyLinkRepository : IRepository<FamilyLink, Guid>
{
}
