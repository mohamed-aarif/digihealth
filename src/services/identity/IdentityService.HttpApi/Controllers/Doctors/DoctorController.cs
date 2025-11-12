using System;
using IdentityService.Doctors;
using IdentityService.Doctors.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.AspNetCore.Mvc;

namespace IdentityService.Controllers.Doctors;

[Route("api/identity/doctors")]
public class DoctorController : AbpCrudController<Doctor, DoctorDto, Guid, PagedAndSortedResultRequestDto, CreateUpdateDoctorDto>
{
    public DoctorController(IDoctorAppService doctorAppService) : base(doctorAppService)
    {
    }
}
