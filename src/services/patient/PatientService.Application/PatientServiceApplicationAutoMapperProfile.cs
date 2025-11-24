using AutoMapper;
using PatientService.Dtos.ExternalLinks;
using PatientService.Dtos.MedicalSummaries;
using PatientService.Dtos.Profiles;
using PatientService.Entities;

namespace PatientService;

public class PatientServiceApplicationAutoMapperProfile : Profile
{
    public PatientServiceApplicationAutoMapperProfile()
    {
        CreateMap<PatientProfileExtension, PatientProfileExtensionDto>();
        CreateMap<CreateUpdatePatientProfileExtensionDto, PatientProfileExtension>();

        CreateMap<PatientMedicalSummary, PatientMedicalSummaryDto>();
        CreateMap<CreateUpdatePatientMedicalSummaryDto, PatientMedicalSummary>();

        CreateMap<PatientExternalLink, PatientExternalLinkDto>();
        CreateMap<CreateUpdatePatientExternalLinkDto, PatientExternalLink>();
    }
}
