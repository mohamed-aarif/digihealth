using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;
using Volo.Abp.MultiTenancy;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var patientGroup = context.AddGroup(PatientServicePermissions.GroupName, L("Permission:PatientService"));

        var profiles = patientGroup.AddPermission(PatientServicePermissions.PatientProfiles.Default, L("Permission:PatientProfiles"));
        profiles.AddChild(PatientServicePermissions.PatientProfiles.Create, L("Permission:Create"));
        profiles.AddChild(PatientServicePermissions.PatientProfiles.Update, L("Permission:Update"));
        profiles.AddChild(PatientServicePermissions.PatientProfiles.Delete, L("Permission:Delete"));

        var summaries = patientGroup.AddPermission(PatientServicePermissions.PatientMedicalSummaries.Default, L("Permission:PatientMedicalSummaries"));
        summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Create, L("Permission:Create"));
        summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Update, L("Permission:Update"));
        summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Delete, L("Permission:Delete"));

        var links = patientGroup.AddPermission(PatientServicePermissions.PatientExternalLinks.Default, L("Permission:PatientExternalLinks"));
        links.AddChild(PatientServicePermissions.PatientExternalLinks.Create, L("Permission:Create"));
        links.AddChild(PatientServicePermissions.PatientExternalLinks.Update, L("Permission:Update"));
        links.AddChild(PatientServicePermissions.PatientExternalLinks.Delete, L("Permission:Delete"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
