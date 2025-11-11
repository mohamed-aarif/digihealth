using System;
using IdentityService.Patients;
using IdentityService.Patients.Dtos;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.Application.Dtos;
using Volo.Abp.AspNetCore.Mvc;

namespace IdentityService.Controllers.Patients;

[Route("api/identity/patients")]
public class PatientController : AbpCrudController<Patient, PatientDto, Guid, PagedAndSortedResultRequestDto, CreateUpdatePatientDto>
{
    public PatientController(IPatientAppService patientAppService) : base(patientAppService)
    {
    }
}
