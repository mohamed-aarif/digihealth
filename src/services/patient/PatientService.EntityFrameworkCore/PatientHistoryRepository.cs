using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Migrations.Internal;

namespace PatientService.EntityFrameworkCore;

public class PatientHistoryRepository : NpgsqlHistoryRepository
{
    public PatientHistoryRepository(HistoryRepositoryDependencies dependencies)
        : base(dependencies)
    {
    }

    protected override string MigrationIdColumnName => "MigrationId";

    protected override string ProductVersionColumnName => "ProductVersion";
}
