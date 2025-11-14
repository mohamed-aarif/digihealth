using AutoMapper;
using IdentityService.Doctors.Dtos;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.Users.Dtos;

namespace IdentityService;

public class IdentityServiceApplicationAutoMapperProfile : Profile
{
    public IdentityServiceApplicationAutoMapperProfile()
    {
        CreateMap<Patients.Patient, PatientDto>();
        CreateMap<CreateUpdatePatientDto, Patients.Patient>();

        CreateMap<Doctors.Doctor, DoctorDto>();
        CreateMap<CreateUpdateDoctorDto, Doctors.Doctor>();

        CreateMap<FamilyLinks.FamilyLink, FamilyLinkDto>();
        CreateMap<CreateUpdateFamilyLinkDto, FamilyLinks.FamilyLink>();

        CreateMap<Users.IdentityUserAccount, IdentityUserAccountDto>();
        CreateMap<CreateUpdateIdentityUserAccountDto, Users.IdentityUserAccount>();
    }
}
