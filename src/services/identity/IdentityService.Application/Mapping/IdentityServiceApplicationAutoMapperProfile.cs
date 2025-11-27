using AutoMapper;
using IdentityService.Doctors.Dtos;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.Users.Dtos;
using Volo.Abp.AutoMapper;

namespace IdentityService;

public class IdentityServiceApplicationAutoMapperProfile : Profile
{
    public IdentityServiceApplicationAutoMapperProfile()
    {
        CreateMap<Doctors.Doctor, DoctorDto>();
        CreateMap<CreateDoctorDto, Doctors.Doctor>(MemberList.Source);
        CreateMap<UpdateDoctorDto, Doctors.Doctor>(MemberList.Source);

        CreateMap<Patients.Patient, PatientDto>();
        CreateMap<CreatePatientDto, Patients.Patient>(MemberList.Source);
        CreateMap<UpdatePatientDto, Patients.Patient>(MemberList.Source);

        CreateMap<FamilyLinks.FamilyLink, FamilyLinkDto>();
        CreateMap<CreateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source);
        CreateMap<UpdateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source);

        CreateMap<Users.UserProfile, UserProfileDto>();
        CreateMap<CreateUserProfileDto, Users.UserProfile>(MemberList.Source);
        CreateMap<UpdateUserProfileDto, Users.UserProfile>(MemberList.Source);
    }
}
