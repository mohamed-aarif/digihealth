using System;
using System.Threading.Tasks;
using PatientService.PatientExternalLinks;
using PatientService.PatientMedicalSummaries;
using PatientService.PatientProfiles;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;

namespace PatientService.Data;

public class PatientServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IRepository<PatientProfileExtension, Guid> _profileRepository;
    private readonly IRepository<PatientMedicalSummary, Guid> _summaryRepository;
    private readonly IRepository<PatientExternalLink, Guid> _linkRepository;

    public PatientServiceDataSeedContributor(
        IRepository<PatientProfileExtension, Guid> profileRepository,
        IRepository<PatientMedicalSummary, Guid> summaryRepository,
        IRepository<PatientExternalLink, Guid> linkRepository)
    {
        _profileRepository = profileRepository;
        _summaryRepository = summaryRepository;
        _linkRepository = linkRepository;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var tenantId = context?.TenantId;

        var demoPatientId = new Guid("11111111-1111-1111-1111-111111111111");
        var profileId = new Guid("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
        var summaryId = new Guid("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb");
        var linkId = new Guid("cccccccc-cccc-cccc-cccc-cccccccccccc");

        if (await _profileRepository.FirstOrDefaultAsync(x => x.IdentityPatientId == demoPatientId) == null)
        {
            var profile = new PatientProfileExtension(profileId, demoPatientId, tenantId);
            profile.UpdateContact("+1-555-0001", null, "demo.patient@example.com");
            profile.UpdateAddress("123 Demo Street", "Suite 100", "Demo City", "CA", "94000", "USA");
            profile.UpdateEmergencyContact("Demo Spouse", "+1-555-9999");
            profile.UpdatePreferredLanguage("en");
            await _profileRepository.InsertAsync(profile, true);
        }

        if (await _summaryRepository.FirstOrDefaultAsync(x => x.IdentityPatientId == demoPatientId) == null)
        {
            var summary = new PatientMedicalSummary(summaryId, demoPatientId, tenantId);
            summary.UpdateDetails("O+", "Peanuts", "Hypertension", "Annual check-up required");
            await _summaryRepository.InsertAsync(summary, true);
        }

        if (await _linkRepository.FirstOrDefaultAsync(x => x.IdentityPatientId == demoPatientId && x.SystemName == "HospitalEMR") == null)
        {
            var link = new PatientExternalLink(linkId, demoPatientId, "HospitalEMR", "EMR-123456", tenantId);
            await _linkRepository.InsertAsync(link, true);
        }
    }
}
