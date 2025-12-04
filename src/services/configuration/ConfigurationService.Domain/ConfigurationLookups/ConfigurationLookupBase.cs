using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp;
using Volo.Abp.Domain.Entities.Auditing;

namespace DigiHealth.ConfigurationService.ConfigurationLookups;

public abstract class ConfigurationLookupBase : FullAuditedAggregateRoot<Guid>
{
    [StringLength(ConfigurationLookupConsts.MaxCodeLength)]
    public string Code { get; private set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.MaxNameLength)]
    public string Name { get; private set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.MaxDescriptionLength)]
    public string? Description { get; private set; }

    public int SortOrder { get; private set; }

    public bool IsActive { get; private set; }

    protected ConfigurationLookupBase()
    {
    }

    protected ConfigurationLookupBase(Guid id, string code, string name, string? description = null, int sortOrder = 0, bool isActive = true)
        : base(id)
    {
        SetCode(code);
        SetName(name);
        Description = Check.Length(description, nameof(description), ConfigurationLookupConsts.MaxDescriptionLength, 0);
        SortOrder = sortOrder;
        IsActive = isActive;
    }

    protected void SetCode(string code)
    {
        Code = Check.NotNullOrWhiteSpace(code, nameof(code), ConfigurationLookupConsts.MaxCodeLength);
    }

    protected void SetName(string name)
    {
        Name = Check.NotNullOrWhiteSpace(name, nameof(name), ConfigurationLookupConsts.MaxNameLength);
    }

    public void UpdateDetails(string code, string name, string? description, int sortOrder, bool isActive)
    {
        SetCode(code);
        SetName(name);
        Description = Check.Length(description, nameof(description), ConfigurationLookupConsts.MaxDescriptionLength, 0);
        SortOrder = sortOrder;
        IsActive = isActive;
    }
}
