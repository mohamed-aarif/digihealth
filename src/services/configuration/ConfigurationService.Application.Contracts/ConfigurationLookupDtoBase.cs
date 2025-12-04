using System;
using System.ComponentModel.DataAnnotations;
using Volo.Abp.Application.Dtos;

namespace DigiHealth.ConfigurationService;

public class ConfigurationLookupDtoBase : EntityDto<Guid>
{
    public string Code { get; set; } = string.Empty;

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public int SortOrder { get; set; }

    public bool IsActive { get; set; }
}

public interface IConfigurationLookupCreateUpdateDto
{
    string Code { get; set; }

    string Name { get; set; }

    string? Description { get; set; }

    int SortOrder { get; set; }

    bool IsActive { get; set; }
}

public abstract class ConfigurationLookupCreateUpdateDtoBase : IConfigurationLookupCreateUpdateDto
{
    [Required]
    [StringLength(ConfigurationLookupConsts.MaxCodeLength)]
    public string Code { get; set; } = string.Empty;

    [Required]
    [StringLength(ConfigurationLookupConsts.MaxNameLength)]
    public string Name { get; set; } = string.Empty;

    [StringLength(ConfigurationLookupConsts.MaxDescriptionLength)]
    public string? Description { get; set; }

    public int SortOrder { get; set; } = 0;

    public bool IsActive { get; set; } = true;
}

public class ConfigurationLookupCreateUpdateDto : ConfigurationLookupCreateUpdateDtoBase
{
}
