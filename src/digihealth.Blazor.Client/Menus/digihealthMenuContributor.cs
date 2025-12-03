using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using digihealth.Localization;
using digihealth.MultiTenancy;
using DigiHealth.ConfigurationService.Permissions;
using Volo.Abp.Account.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Identity.Blazor;
using Volo.Abp.SettingManagement.Blazor.Menus;
using Volo.Abp.TenantManagement.Blazor.Navigation;
using Volo.Abp.UI.Navigation;

namespace digihealth.Blazor.Client.Menus;

public class digihealthMenuContributor : IMenuContributor
{
    private readonly IConfiguration _configuration;

    public digihealthMenuContributor(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public async Task ConfigureMenuAsync(MenuConfigurationContext context)
    {
        if (context.Menu.Name == StandardMenus.Main)
        {
            await ConfigureMainMenuAsync(context);
        }
        else if (context.Menu.Name == StandardMenus.User)
        {
            await ConfigureUserMenuAsync(context);
        }
    }

    private async Task ConfigureMainMenuAsync(MenuConfigurationContext context)
    {
        var l = context.GetLocalizer<digihealthResource>();

        context.Menu.Items.Insert(
            0,
            new ApplicationMenuItem(
                digihealthMenus.Home,
                l["Menu:Home"],
                "/",
                icon: "fas fa-home"
            )
        );

        var configurationMenu = new ApplicationMenuItem(
            "Configuration",
            l["Menu:Configuration"],
            icon: "fa fa-sliders-h"
        );

        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.AppointmentStatuses.Default,
            "Configuration.AppointmentStatuses", "Menu:Configuration.AppointmentStatuses", "/configuration/appointment-statuses", "fa fa-list");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.AppointmentChannels.Default,
            "Configuration.AppointmentChannels", "Menu:Configuration.AppointmentChannels", "/configuration/appointment-channels", "fa fa-video");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.ConsentPartyTypes.Default,
            "Configuration.ConsentPartyTypes", "Menu:Configuration.ConsentPartyTypes", "/configuration/consent-party-types", "fa fa-user-friends");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.ConsentStatuses.Default,
            "Configuration.ConsentStatuses", "Menu:Configuration.ConsentStatuses", "/configuration/consent-statuses", "fa fa-check-square");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.DaysOfWeek.Default,
            "Configuration.DaysOfWeek", "Menu:Configuration.DaysOfWeek", "/configuration/days-of-week", "fa fa-calendar");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.DeviceTypes.Default,
            "Configuration.DeviceTypes", "Menu:Configuration.DeviceTypes", "/configuration/device-types", "fa fa-stethoscope");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.MedicationIntakeStatuses.Default,
            "Configuration.MedicationIntakeStatuses", "Menu:Configuration.MedicationIntakeStatuses", "/configuration/medication-intake-statuses", "fa fa-pills");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.NotificationChannels.Default,
            "Configuration.NotificationChannels", "Menu:Configuration.NotificationChannels", "/configuration/notification-channels", "fa fa-bell");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.NotificationStatuses.Default,
            "Configuration.NotificationStatuses", "Menu:Configuration.NotificationStatuses", "/configuration/notification-statuses", "fa fa-envelope-open");
        await AddConfigurationItemAsync(context, configurationMenu, ConfigurationPermissions.VaultRecordTypes.Default,
            "Configuration.VaultRecordTypes", "Menu:Configuration.VaultRecordTypes", "/configuration/vault-record-types", "fa fa-database");

        if (configurationMenu.Items.Count > 0)
        {
            context.Menu.AddItem(configurationMenu);
        }

        var administration = context.Menu.GetAdministration();
        var isMultiTenancyEnabled = MultiTenancyConsts.IsEnabled;

        if (isMultiTenancyEnabled)
        {
            administration.SetSubItemOrder(TenantManagementMenuNames.GroupName, 1);
        }
        else
        {
            administration.TryRemoveMenuItem(TenantManagementMenuNames.GroupName);
        }

        administration.SetSubItemOrder(IdentityMenuNames.GroupName, 2);
        administration.SetSubItemOrder(SettingManagementMenus.GroupName, 3);

        return;
    }

    private static async Task AddConfigurationItemAsync(MenuConfigurationContext context, ApplicationMenuItem configurationMenu,
        string permission, string name, string displayName, string url, string? icon = null)
    {
        if (await context.IsGrantedAsync(permission))
        {
            configurationMenu.AddItem(new ApplicationMenuItem(name, context.GetLocalizer<digihealthResource>()[displayName], url,
                icon: icon));
        }
    }

    private Task ConfigureUserMenuAsync(MenuConfigurationContext context)
    {
        var accountStringLocalizer = context.GetLocalizer<AccountResource>();

        var authServerUrl = _configuration["AuthServer:Authority"] ?? "";

        context.Menu.AddItem(new ApplicationMenuItem(
            "Account.Manage",
            accountStringLocalizer["MyAccount"],
            $"{authServerUrl.EnsureEndsWith('/')}Account/Manage",
            icon: "fa fa-cog",
            order: 1000,
            target: "_blank").RequireAuthenticated());

        return Task.CompletedTask;
    }
}
