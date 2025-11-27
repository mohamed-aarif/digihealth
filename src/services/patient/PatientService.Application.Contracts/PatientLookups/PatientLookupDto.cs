using System;
using System.Collections.Generic;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.Users.Dtos;
using Volo.Abp.Application.Dtos;

namespace PatientService.PatientLookups;

public class PatientLookupDto : EntityDto<Guid>
{
    public PatientDto Patient { get; set; } = default!;

    public UserProfileDto? UserProfile { get; set; }

    public IReadOnlyList<FamilyLinkDto> FamilyLinks { get; set; } = Array.Empty<FamilyLinkDto>();
}
