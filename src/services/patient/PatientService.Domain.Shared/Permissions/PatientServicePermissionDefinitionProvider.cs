using System.Linq;
using PatientService.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;

namespace PatientService.Permissions;

public class PatientServicePermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var patientGroup = context.GetGroupOrNull(DigiHealthPatientPermissions.GroupName)
                          ?? context.AddGroup(DigiHealthPatientPermissions.GroupName, L("Permission:PatientService"));

        AddChildPermissions(
            patientGroup.GetPermissionOrNull(DigiHealthPatientPermissions.PatientProfileExtensions.Default)
            ?? patientGroup.AddPermission(DigiHealthPatientPermissions.PatientProfileExtensions.Default, L("Permission:PatientProfiles")),
            DigiHealthPatientPermissions.PatientProfileExtensions.Create,
            DigiHealthPatientPermissions.PatientProfileExtensions.Edit,
            DigiHealthPatientPermissions.PatientProfileExtensions.Delete);

        AddChildPermissions(
            patientGroup.GetPermissionOrNull(DigiHealthPatientPermissions.PatientMedicalSummaries.Default)
            ?? patientGroup.AddPermission(DigiHealthPatientPermissions.PatientMedicalSummaries.Default, L("Permission:PatientMedicalSummaries")),
            DigiHealthPatientPermissions.PatientMedicalSummaries.Create,
            DigiHealthPatientPermissions.PatientMedicalSummaries.Edit,
            DigiHealthPatientPermissions.PatientMedicalSummaries.Delete);

        AddChildPermissions(
            patientGroup.GetPermissionOrNull(DigiHealthPatientPermissions.PatientExternalLinks.Default)
            ?? patientGroup.AddPermission(DigiHealthPatientPermissions.PatientExternalLinks.Default, L("Permission:PatientExternalLinks")),
            DigiHealthPatientPermissions.PatientExternalLinks.Create,
            DigiHealthPatientPermissions.PatientExternalLinks.Edit,
            DigiHealthPatientPermissions.PatientExternalLinks.Delete);

        AddChildPermissions(
            patientGroup.GetPermissionOrNull(DigiHealthPatientPermissions.Meals.Default)
            ?? patientGroup.AddPermission(DigiHealthPatientPermissions.Meals.Default, L("Permission:Meals")),
            DigiHealthPatientPermissions.Meals.Create,
            DigiHealthPatientPermissions.Meals.Edit,
            DigiHealthPatientPermissions.Meals.Delete);

        AddChildPermissions(
            patientGroup.GetPermissionOrNull(DigiHealthPatientPermissions.MealItems.Default)
            ?? patientGroup.AddPermission(DigiHealthPatientPermissions.MealItems.Default, L("Permission:MealItems")),
            DigiHealthPatientPermissions.MealItems.Create,
            DigiHealthPatientPermissions.MealItems.Edit,
            DigiHealthPatientPermissions.MealItems.Delete);

        _ = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientLookups.Default)
            ?? patientGroup.AddPermission(PatientServicePermissions.PatientLookups.Default, L("Permission:PatientLookups"));
        _ = patientGroup.GetPermissionOrNull(PatientServicePermissions.PatientSummaries.Default)
            ?? patientGroup.AddPermission(PatientServicePermissions.PatientSummaries.Default, L("Permission:PatientSummaries"));
    }

    private static void AddChildPermissions(PermissionDefinition parent, params string[] children)
    {
        foreach (var child in children)
        {
            _ = parent.Children.FirstOrDefault(c => c.Name == child) ?? parent.AddChild(child, LocalizeChild(child));
        }
    }

    private static LocalizableString LocalizeChild(string name)
    {
        var suffix = name.Split('.').Last();
        return L($"Permission:{suffix}");
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<PatientServiceResource>(name);
    }
}
