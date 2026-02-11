using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace AiChatBot.AdminPortal.EntityFrameworkCore.Migrations;

public partial class AddTenantChatWidgetConfig : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.CreateTable(
            name: "AdminPortalTenantChatWidgetConfigs",
            columns: table => new
            {
                Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                TenantId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                IsEnabled = table.Column<bool>(type: "bit", nullable: false),
                DefaultConfigJson = table.Column<string>(type: "nvarchar(max)", nullable: false),
                ConfigVersion = table.Column<int>(type: "int", nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_AdminPortalTenantChatWidgetConfigs", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "AdminPortalTenantChatWidgetChannelConfigs",
            columns: table => new
            {
                Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                TenantChatWidgetConfigId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                TenantId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                ChannelId = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                IsEnabled = table.Column<bool>(type: "bit", nullable: false),
                DomainsAllowedJson = table.Column<string>(type: "nvarchar(max)", nullable: true),
                ConfigJson = table.Column<string>(type: "nvarchar(max)", nullable: true),
                ConfigVersion = table.Column<int>(type: "int", nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_AdminPortalTenantChatWidgetChannelConfigs", x => x.Id);
                table.ForeignKey(
                    name: "FK_AdminPortalTenantChatWidgetChannelConfigs_AdminPortalTenantChatWidgetConfigs_TenantChatWidgetConfigId",
                    column: x => x.TenantChatWidgetConfigId,
                    principalTable: "AdminPortalTenantChatWidgetConfigs",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateIndex(
            name: "IX_AdminPortalTenantChatWidgetChannelConfigs_TenantChatWidgetConfigId",
            table: "AdminPortalTenantChatWidgetChannelConfigs",
            column: "TenantChatWidgetConfigId");

        migrationBuilder.CreateIndex(
            name: "IX_AdminPortalTenantChatWidgetChannelConfigs_TenantId_ChannelId",
            table: "AdminPortalTenantChatWidgetChannelConfigs",
            columns: new[] { "TenantId", "ChannelId" },
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_AdminPortalTenantChatWidgetConfigs_TenantId",
            table: "AdminPortalTenantChatWidgetConfigs",
            column: "TenantId",
            unique: true);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropTable(
            name: "AdminPortalTenantChatWidgetChannelConfigs");

        migrationBuilder.DropTable(
            name: "AdminPortalTenantChatWidgetConfigs");
    }
}

// Commands used for migration lifecycle:
// dotnet ef migrations add AddTenantChatWidgetConfig -p AdminPortal/src/AiChatBot.AdminPortal.EntityFrameworkCore -s AdminPortal/src/AiChatBot.AdminPortal.DbMigrator
// dotnet ef database update -p AdminPortal/src/AiChatBot.AdminPortal.EntityFrameworkCore -s AdminPortal/src/AiChatBot.AdminPortal.DbMigrator
