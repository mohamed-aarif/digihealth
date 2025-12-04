using System;
using IdentityService.DoctorPatientLinks.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.DoctorPatientLinks;

public interface IDoctorPatientLinkAppService :
    ICrudAppService<
        DoctorPatientLinkDto,
        Guid,
        DoctorPatientLinkPagedAndSortedResultRequestDto,
        CreateDoctorPatientLinkDto,
        UpdateDoctorPatientLinkDto>
{
}
