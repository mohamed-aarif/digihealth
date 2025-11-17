using AutoMapper;
using IdentityService.Doctors.Dtos;
using IdentityService.Patients.Dtos;

namespace IdentityService;

public class IdentityServiceApplicationAutoMapperProfile : Profile
{
    public IdentityServiceApplicationAutoMapperProfile()
    {
        CreateMap<Doctors.Doctor, DoctorDto>();
        CreateMap<CreateUpdateDoctorDto, Doctors.Doctor>();

        CreateMap<Patients.Patient, PatientDto>();
        CreateMap<CreateUpdatePatientDto, Patients.Patient>();
    }
}
