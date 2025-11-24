using AutoMapper;
using PatientService.Patients;

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
