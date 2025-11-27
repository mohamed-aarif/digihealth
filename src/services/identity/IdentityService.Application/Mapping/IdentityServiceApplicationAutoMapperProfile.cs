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
        CreateMap<Doctors.Doctor, DoctorDto>().MapExtraProperties();
        CreateMap<CreateDoctorDto, Doctors.Doctor>(MemberList.Source).MapExtraProperties();
        CreateMap<UpdateDoctorDto, Doctors.Doctor>(MemberList.Source).MapExtraProperties();

        CreateMap<Patients.Patient, PatientDto>().MapExtraProperties();
        CreateMap<CreatePatientDto, Patients.Patient>(MemberList.Source).MapExtraProperties();
        CreateMap<UpdatePatientDto, Patients.Patient>(MemberList.Source).MapExtraProperties();

        CreateMap<FamilyLinks.FamilyLink, FamilyLinkDto>().MapExtraProperties();
        CreateMap<CreateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source).MapExtraProperties();
        CreateMap<UpdateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source).MapExtraProperties();

        CreateMap<Users.UserProfile, UserProfileDto>().MapExtraProperties();
        CreateMap<CreateUserProfileDto, Users.UserProfile>(MemberList.Source).MapExtraProperties();
        CreateMap<UpdateUserProfileDto, Users.UserProfile>(MemberList.Source).MapExtraProperties();
    }
}
