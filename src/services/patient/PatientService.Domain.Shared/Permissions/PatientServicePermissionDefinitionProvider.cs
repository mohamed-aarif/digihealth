using System.Linq;
using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;
using Volo.Abp.MultiTenancy;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var patientGroup = context.GetGroupOrNull(PatientServicePermissions.GroupName)
                          ?? context.AddGroup(PatientServicePermissions.GroupName, L("Permission:PatientService"));

        var profiles = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientProfiles.Default)
                      ?? patientGroup.AddPermission(PatientServicePermissions.PatientProfiles.Default, L("Permission:PatientProfiles"));
        _ = profiles.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientProfiles.Create)
            ?? profiles.AddChild(PatientServicePermissions.PatientProfiles.Create, L("Permission:Create"));
        _ = profiles.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientProfiles.Update)
            ?? profiles.AddChild(PatientServicePermissions.PatientProfiles.Update, L("Permission:Update"));
        _ = profiles.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientProfiles.Delete)
            ?? profiles.AddChild(PatientServicePermissions.PatientProfiles.Delete, L("Permission:Delete"));

        var summaries = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientMedicalSummaries.Default)
                       ?? patientGroup.AddPermission(PatientServicePermissions.PatientMedicalSummaries.Default, L("Permission:PatientMedicalSummaries"));
        _ = summaries.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientMedicalSummaries.Create)
            ?? summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Create, L("Permission:Create"));
        _ = summaries.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientMedicalSummaries.Update)
            ?? summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Update, L("Permission:Update"));
        _ = summaries.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientMedicalSummaries.Delete)
            ?? summaries.AddChild(PatientServicePermissions.PatientMedicalSummaries.Delete, L("Permission:Delete"));

        var links = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientExternalLinks.Default)
                   ?? patientGroup.AddPermission(PatientServicePermissions.PatientExternalLinks.Default, L("Permission:PatientExternalLinks"));
        _ = links.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientExternalLinks.Create)
            ?? links.AddChild(PatientServicePermissions.PatientExternalLinks.Create, L("Permission:Create"));
        _ = links.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientExternalLinks.Update)
            ?? links.AddChild(PatientServicePermissions.PatientExternalLinks.Update, L("Permission:Update"));
        _ = links.Children.FirstOrDefault(child => child.Name == PatientServicePermissions.PatientExternalLinks.Delete)
            ?? links.AddChild(PatientServicePermissions.PatientExternalLinks.Delete, L("Permission:Delete"));

        _ = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientLookups.Default)
            ?? patientGroup.AddPermission(PatientServicePermissions.PatientLookups.Default, L("Permission:PatientLookups"));
        _ = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientSummaries.Default)
            ?? patientGroup.AddPermission(PatientServicePermissions.PatientSummaries.Default, L("Permission:PatientSummaries"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
