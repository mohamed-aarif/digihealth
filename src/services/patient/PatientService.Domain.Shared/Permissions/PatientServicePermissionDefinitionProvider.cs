using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var patientGroup = context.AddGroup(PatientServicePermissions.GroupName, L("Permission:PatientService"));

        var profilesPermission = patientGroup.AddPermission(PatientServicePermissions.PatientProfiles.Default, L("Permission:PatientProfiles"));
        profilesPermission.AddChild(PatientServicePermissions.PatientProfiles.Manage, L("Permission:PatientProfiles.Manage"));

        var summariesPermission = patientGroup.AddPermission(PatientServicePermissions.MedicalSummaries.Default, L("Permission:MedicalSummaries"));
        summariesPermission.AddChild(PatientServicePermissions.MedicalSummaries.Manage, L("Permission:MedicalSummaries.Manage"));

        var externalLinksPermission = patientGroup.AddPermission(PatientServicePermissions.ExternalLinks.Default, L("Permission:ExternalLinks"));
        externalLinksPermission.AddChild(PatientServicePermissions.ExternalLinks.Manage, L("Permission:ExternalLinks.Manage"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
