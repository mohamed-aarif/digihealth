using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PatientService.MedicalSummaries;
using PatientService.PatientProfiles;
using Volo.Abp.Data;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Domain.Repositories;
using Volo.Abp.Guids;
using Volo.Abp.MultiTenancy;
using Microsoft.Extensions.Options;

namespace PatientService.Data;

public class PatientServiceDataSeedContributor : IDataSeedContributor, ITransientDependency
{
    private readonly IRepository<PatientProfileExtension, Guid> _profileRepository;
    private readonly IRepository<PatientMedicalSummary, Guid> _summaryRepository;
    private readonly IGuidGenerator _guidGenerator;
    private readonly ICurrentTenant _currentTenant;
    private readonly PatientServiceSeedOptions _seedOptions;

    public PatientServiceDataSeedContributor(
        IRepository<PatientProfileExtension, Guid> profileRepository,
        IRepository<PatientMedicalSummary, Guid> summaryRepository,
        IGuidGenerator guidGenerator,
        ICurrentTenant currentTenant,
        IOptions<PatientServiceSeedOptions> seedOptions)
    {
        _profileRepository = profileRepository;
        _summaryRepository = summaryRepository;
        _guidGenerator = guidGenerator;
        _currentTenant = currentTenant;
        _seedOptions = seedOptions.Value;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        var tenantId = context?.TenantId;
        using var change = _currentTenant.Change(tenantId);

        var identityPatients = _seedOptions.IdentityPatientIds.Any()
            ? _seedOptions.IdentityPatientIds
            : new List<Guid>
            {
                Guid.Parse("11111111-1111-1111-1111-111111111111"),
                Guid.Parse("22222222-2222-2222-2222-222222222222")
            };

        var cityIterator = new Queue<string>(new[] { "Dubai", "Abu Dhabi", "Sharjah" });

        foreach (var identityPatientId in identityPatients)
        {
            if (!await _profileRepository.AnyAsync(x => x.IdentityPatientId == identityPatientId))
            {
                await _profileRepository.InsertAsync(
                    new PatientProfileExtension(
                        _guidGenerator.Create(),
                        identityPatientId,
                        tenantId,
                        "+971500000001",
                        null,
                        $"patient{identityPatients.IndexOf(identityPatientId) + 1}@clinic.local",
                        "Street 1",
                        "",
                        cityIterator.TryDequeue(out var city) ? city : "Dubai",
                        "",
                        "00000",
                        "UAE",
                        "Emergency Contact",
                        "+971500000099",
                        "English"),
                    autoSave: true);
            }

            if (!await _summaryRepository.AnyAsync(x => x.IdentityPatientId == identityPatientId))
            {
                await _summaryRepository.InsertAsync(
                    new PatientMedicalSummary(
                        _guidGenerator.Create(),
                        identityPatientId,
                        tenantId,
                        "O+",
                        "None",
                        "None",
                        "No significant medical history."),
                    autoSave: true);
            }
        }
    }
}
