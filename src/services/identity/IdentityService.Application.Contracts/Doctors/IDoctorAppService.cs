using System;
using IdentityService.Doctors.Dtos;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace IdentityService.Doctors;

public interface IDoctorAppService :
    ICrudAppService<
        DoctorDto,
        Guid,
        DoctorPagedAndSortedResultRequestDto,
        CreateUpdateDoctorDto>
{
}
