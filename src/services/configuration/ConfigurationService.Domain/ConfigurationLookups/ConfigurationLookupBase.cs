using System;
using Volo.Abp.Domain.Entities;

namespace DigiHealth.ConfigurationService.ConfigurationLookups;

public class ConfigurationLookupBase : AggregateRoot<Guid>
{
    public string Code { get; set; }

    public string Name { get; set; }

    public string? Description { get; set; }

    public int SortOrder { get; set; }

    public bool IsActive { get; set; }

    protected ConfigurationLookupBase()
    {
    }

    public ConfigurationLookupBase(Guid id, string code, string name, string? description, int sortOrder, bool isActive) : base(id)
    {
        Code = code;
        Name = name;
        Description = description;
        SortOrder = sortOrder;
        IsActive = isActive;
    }
}
