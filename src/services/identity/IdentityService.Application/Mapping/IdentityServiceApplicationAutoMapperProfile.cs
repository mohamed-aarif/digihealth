using AutoMapper;
using IdentityService.Doctors.Dtos;
using IdentityService.DoctorPatientLinks.Dtos;
using IdentityService.FamilyLinks.Dtos;
using IdentityService.HealthPassports.Dtos;
using IdentityService.Patients.Dtos;
using IdentityService.SubscriptionPlans.Dtos;
using IdentityService.UserSubscriptions.Dtos;
using IdentityService.Users.Dtos;
using Volo.Abp.AutoMapper;

namespace IdentityService;

public class IdentityServiceApplicationAutoMapperProfile : Profile
{
    public IdentityServiceApplicationAutoMapperProfile()
    {
        CreateMap<Doctors.Doctor, DoctorDto>()
            .ForMember(x => x.UserName, opt => opt.Ignore())
            .ForMember(x => x.Name, opt => opt.Ignore())
            .ForMember(x => x.Surname, opt => opt.Ignore())
            .ForMember(x => x.ProfilePhotoUrl, opt => opt.Ignore());
        CreateMap<CreateDoctorDto, Doctors.Doctor>(MemberList.Source);
        CreateMap<UpdateDoctorDto, Doctors.Doctor>(MemberList.Source);

        CreateMap<Patients.Patient, PatientDto>()
            .ForMember(x => x.UserName, opt => opt.Ignore())
            .ForMember(x => x.Name, opt => opt.Ignore())
            .ForMember(x => x.Surname, opt => opt.Ignore())
            .ForMember(x => x.ProfilePhotoUrl, opt => opt.Ignore());
        CreateMap<CreatePatientDto, Patients.Patient>(MemberList.Source);
        CreateMap<UpdatePatientDto, Patients.Patient>(MemberList.Source);

        CreateMap<FamilyLinks.FamilyLink, FamilyLinkDto>();
        CreateMap<CreateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source);
        CreateMap<UpdateFamilyLinkDto, FamilyLinks.FamilyLink>(MemberList.Source);

        CreateMap<DoctorPatientLinks.DoctorPatientLink, DoctorPatientLinkDto>();
        CreateMap<CreateDoctorPatientLinkDto, DoctorPatientLinks.DoctorPatientLink>(MemberList.Source);
        CreateMap<UpdateDoctorPatientLinkDto, DoctorPatientLinks.DoctorPatientLink>(MemberList.Source);

        CreateMap<HealthPassports.HealthPassport, HealthPassportDto>();
        CreateMap<CreateHealthPassportDto, HealthPassports.HealthPassport>(MemberList.Source);
        CreateMap<UpdateHealthPassportDto, HealthPassports.HealthPassport>(MemberList.Source);

        CreateMap<SubscriptionPlans.SubscriptionPlan, SubscriptionPlanDto>();
        CreateMap<CreateSubscriptionPlanDto, SubscriptionPlans.SubscriptionPlan>(MemberList.Source);
        CreateMap<UpdateSubscriptionPlanDto, SubscriptionPlans.SubscriptionPlan>(MemberList.Source);

        CreateMap<UserSubscriptions.UserSubscription, UserSubscriptionDto>();
        CreateMap<CreateUserSubscriptionDto, UserSubscriptions.UserSubscription>(MemberList.Source);
        CreateMap<UpdateUserSubscriptionDto, UserSubscriptions.UserSubscription>(MemberList.Source);

        CreateMap<Users.UserProfile, UserProfileDto>();
        CreateMap<CreateUserProfileDto, Users.UserProfile>(MemberList.Source);
        CreateMap<UpdateUserProfileDto, Users.UserProfile>(MemberList.Source);
    }
}
