using System;
using System.Threading.Tasks;
using PatientService.Patients;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Guids;
using Volo.Abp.MultiTenancy;

namespace PatientService.Data;

public class PatientServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IRepository<PatientProfileExtension, Guid> _profileRepository;
    private readonly IRepository<PatientMedicalSummary, Guid> _summaryRepository;
    private readonly IRepository<PatientExternalLink, Guid> _linkRepository;
    private readonly IGuidGenerator _guidGenerator;
    private readonly ICurrentTenant _currentTenant;

    public PatientServiceDataSeedContributor(
        IRepository<PatientProfileExtension, Guid> profileRepository,
        IRepository<PatientMedicalSummary, Guid> summaryRepository,
        IRepository<PatientExternalLink, Guid> linkRepository,
        IGuidGenerator guidGenerator,
        ICurrentTenant currentTenant)
    {
        _profileRepository = profileRepository;
        _summaryRepository = summaryRepository;
        _linkRepository = linkRepository;
        _guidGenerator = guidGenerator;
        _currentTenant = currentTenant;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var tenantId = context.TenantId ?? _currentTenant.Id;

        var sampleIdentityPatientId = context.Properties.TryGetValue("IdentityPatientId", out var identityValue)
            ? Guid.Parse(identityValue.ToString()!)
            : Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");

        if (!await _profileRepository.AnyAsync(x => x.IdentityPatientId == sampleIdentityPatientId))
        {
            var profile = new PatientProfileExtension(
                _guidGenerator.Create(),
                sampleIdentityPatientId,
                tenantId,
                "+971500000001",
                null,
                "patient1@defaultclinic.local",
                "123 Demo Street",
                null,
                "Dubai",
                "Dubai",
                "00000",
                "UAE",
                "Demo Emergency",
                "+971500000099",
                "English");

            await _profileRepository.InsertAsync(profile, autoSave: true);
        }

        if (!await _summaryRepository.AnyAsync(x => x.IdentityPatientId == sampleIdentityPatientId))
        {
            var summary = new PatientMedicalSummary(
                _guidGenerator.Create(),
                sampleIdentityPatientId,
                tenantId,
                "O+",
                "Peanuts",
                "Hypertension",
                "Sample demo medical summary record.");

            await _summaryRepository.InsertAsync(summary, autoSave: true);
        }

        if (!await _linkRepository.AnyAsync(x => x.IdentityPatientId == sampleIdentityPatientId))
        {
            await _linkRepository.InsertAsync(
                new PatientExternalLink(
                    _guidGenerator.Create(),
                    sampleIdentityPatientId,
                    tenantId,
                    "HospitalEMR",
                    "EMR-123"),
                autoSave: true);
        }
    }
}
