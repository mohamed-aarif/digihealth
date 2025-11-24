using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var group = context.AddGroup(PatientServicePermissions.GroupName, L("Permission:PatientService"));

        var profilePermission = group.AddPermission(
            PatientServicePermissions.PatientProfiles.Default,
            L("Permission:PatientProfiles"));
        profilePermission.AddChild(
            PatientServicePermissions.PatientProfiles.Manage,
            L("Permission:PatientProfiles.Manage"));

        var summaryPermission = group.AddPermission(
            PatientServicePermissions.PatientMedicalSummaries.Default,
            L("Permission:PatientMedicalSummaries"));
        summaryPermission.AddChild(
            PatientServicePermissions.PatientMedicalSummaries.Manage,
            L("Permission:PatientMedicalSummaries.Manage"));

        var linkPermission = group.AddPermission(
            PatientServicePermissions.PatientExternalLinks.Default,
            L("Permission:PatientExternalLinks"));
        linkPermission.AddChild(
            PatientServicePermissions.PatientExternalLinks.Manage,
            L("Permission:PatientExternalLinks.Manage"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
