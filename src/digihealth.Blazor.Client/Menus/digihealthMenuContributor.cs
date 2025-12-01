using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using digihealth.Localization;
using digihealth.MultiTenancy;
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

    private Task ConfigureMainMenuAsync(MenuConfigurationContext context)
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
            "Configuration",
            icon: "fa fa-sliders-h"
        );

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.AppointmentStatuses",
            "Appointment Statuses",
            "/configuration/appointment-statuses",
            icon: "fa fa-list"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.AppointmentChannels",
            "Appointment Channels",
            "/configuration/appointment-channels",
            icon: "fa fa-video"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.ConsentPartyTypes",
            "Consent Party Types",
            "/configuration/consent-party-types",
            icon: "fa fa-user-friends"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.ConsentStatuses",
            "Consent Statuses",
            "/configuration/consent-statuses",
            icon: "fa fa-check-square"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.DaysOfWeek",
            "Days of Week",
            "/configuration/days-of-week",
            icon: "fa fa-calendar"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.DeviceTypes",
            "Device Types",
            "/configuration/device-types",
            icon: "fa fa-stethoscope"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.MedicationIntakeStatuses",
            "Medication Intake Statuses",
            "/configuration/medication-intake-statuses",
            icon: "fa fa-pills"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.NotificationChannels",
            "Notification Channels",
            "/configuration/notification-channels",
            icon: "fa fa-bell"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.NotificationStatuses",
            "Notification Statuses",
            "/configuration/notification-statuses",
            icon: "fa fa-envelope-open"
        ));

        configurationMenu.AddItem(new ApplicationMenuItem(
            "Configuration.VaultRecordTypes",
            "Vault Record Types",
            "/configuration/vault-record-types",
            icon: "fa fa-database"
        ));

        context.Menu.AddItem(configurationMenu);

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

        return Task.CompletedTask;
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
