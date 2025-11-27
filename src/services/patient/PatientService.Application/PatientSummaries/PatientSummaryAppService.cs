using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using PatientService.PatientExternalLinks;
using PatientService.PatientLookups;
using PatientService.PatientMedicalSummaries;
using PatientService.PatientProfiles;
using PatientService.Permissions;
using Volo.Abp.Application.Services;
using Volo.Abp.Authorization;
using Volo.Abp.Domain.Repositories;

namespace PatientService.PatientSummaries;

[Authorize(PatientServicePermissions.PatientSummaries.Default)]
public class PatientSummaryAppService : ApplicationService, IPatientSummaryAppService
{
    private readonly IPatientLookupAppService _patientLookupAppService;
    private readonly IPatientProfileAppService _patientProfileAppService;
    private readonly IPatientMedicalSummaryAppService _patientMedicalSummaryAppService;
    private readonly IRepository<PatientExternalLink, Guid> _patientExternalLinkRepository;

    public PatientSummaryAppService(
        IPatientLookupAppService patientLookupAppService,
        IPatientProfileAppService patientProfileAppService,
        IPatientMedicalSummaryAppService patientMedicalSummaryAppService,
        IRepository<PatientExternalLink, Guid> patientExternalLinkRepository)
    {
        _patientLookupAppService = patientLookupAppService;
        _patientProfileAppService = patientProfileAppService;
        _patientMedicalSummaryAppService = patientMedicalSummaryAppService;
        _patientExternalLinkRepository = patientExternalLinkRepository;
    }

    public async Task<PatientSummaryDto?> GetAsync(Guid identityPatientId)
    {
        var lookup = await _patientLookupAppService.GetAsync(identityPatientId);
        if (lookup == null)
        {
            return null;
        }

        var profileExtension = await _patientProfileAppService.GetByIdentityPatientIdAsync(identityPatientId);
        var medicalSummary = await _patientMedicalSummaryAppService.GetByIdentityPatientIdAsync(identityPatientId);
        var externalLinks = await _patientExternalLinkRepository.GetListAsync(x => x.IdentityPatientId == identityPatientId);

        return new PatientSummaryDto
        {
            Id = identityPatientId,
            IdentityPatientId = identityPatientId,
            Patient = lookup.Patient,
            UserProfile = lookup.UserProfile,
            FamilyLinks = lookup.FamilyLinks,
            ProfileExtension = profileExtension,
            MedicalSummary = medicalSummary,
            ExternalLinks = ObjectMapper.Map<List<PatientExternalLink>, List<PatientExternalLinkDto>>(externalLinks)
        };
    }
}
