using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var group = context.AddGroup(PatientServicePermissions.GroupName, L("Permission:PatientService"));

        var profilePermission = group.AddPermission(PatientServicePermissions.PatientProfiles.Default, L("Permission:PatientProfiles"));
        profilePermission.AddChild(PatientServicePermissions.PatientProfiles.Create, L("Permission:Create"));
        profilePermission.AddChild(PatientServicePermissions.PatientProfiles.Update, L("Permission:Edit"));
        profilePermission.AddChild(PatientServicePermissions.PatientProfiles.Delete, L("Permission:Delete"));

        var medicalPermission = group.AddPermission(PatientServicePermissions.MedicalSummaries.Default, L("Permission:MedicalSummaries"));
        medicalPermission.AddChild(PatientServicePermissions.MedicalSummaries.Create, L("Permission:Create"));
        medicalPermission.AddChild(PatientServicePermissions.MedicalSummaries.Update, L("Permission:Edit"));
        medicalPermission.AddChild(PatientServicePermissions.MedicalSummaries.Delete, L("Permission:Delete"));

        var linkPermission = group.AddPermission(PatientServicePermissions.ExternalLinks.Default, L("Permission:ExternalLinks"));
        linkPermission.AddChild(PatientServicePermissions.ExternalLinks.Create, L("Permission:Create"));
        linkPermission.AddChild(PatientServicePermissions.ExternalLinks.Update, L("Permission:Edit"));
        linkPermission.AddChild(PatientServicePermissions.ExternalLinks.Delete, L("Permission:Delete"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
