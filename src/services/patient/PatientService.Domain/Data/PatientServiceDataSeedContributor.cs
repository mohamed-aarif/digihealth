using System;
using System.Linq;
using System.Threading.Tasks;
using PatientService.Entities;
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
    private readonly PatientServiceSeedDataOptions _seedOptions;

    public PatientServiceDataSeedContributor(
        IRepository<PatientProfileExtension, Guid> profileRepository,
        IRepository<PatientMedicalSummary, Guid> summaryRepository,
        IGuidGenerator guidGenerator,
        ICurrentTenant currentTenant,
        IOptions<PatientServiceSeedDataOptions> seedOptions)
    {
        _profileRepository = profileRepository;
        _summaryRepository = summaryRepository;
        _guidGenerator = guidGenerator;
        _currentTenant = currentTenant;
        _seedOptions = seedOptions.Value;
    }

    public async Task SeedAsync(DataSeedContext context)
    {
        foreach (var kvp in _seedOptions.IdentityPatientIds)
        {
            using (_currentTenant.Change(context?.TenantId))
            {
                var identityPatientId = kvp.Value;

                if (!await _profileRepository.AnyAsync(x => x.IdentityPatientId == identityPatientId))
                {
                    var profile = new PatientProfileExtension(
                        _guidGenerator.Create(),
                        identityPatientId,
                        context?.TenantId,
                        "+971500000001",
                        null,
                        "patient@example.com",
                        "123 Sample St",
                        null,
                        "Dubai",
                        "Dubai",
                        "00000",
                        "UAE",
                        "John Emergency",
                        "+971511111111",
                        "English");

                    await _profileRepository.InsertAsync(profile, autoSave: true);
                }

                if (!await _summaryRepository.AnyAsync(x => x.IdentityPatientId == identityPatientId))
                {
                    var summary = new PatientMedicalSummary(
                        _guidGenerator.Create(),
                        identityPatientId,
                        context?.TenantId,
                        "O+",
                        "Peanuts",
                        "Hypertension",
                        "Regular checkups recommended.");

                    await _summaryRepository.InsertAsync(summary, autoSave: true);
                }
            }
        }
    }
}
