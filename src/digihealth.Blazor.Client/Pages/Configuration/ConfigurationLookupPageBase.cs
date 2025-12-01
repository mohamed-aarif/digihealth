using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Blazorise;
using DigiHealth.ConfigurationService;
using Microsoft.AspNetCore.Components;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;
using Volo.Abp.DependencyInjection;

namespace digihealth.Blazor.Client.Pages.Configuration;

public abstract class ConfigurationLookupPageBase<TAppService, TDto, TCreateUpdateDto> : digihealthComponentBase
    where TDto : ConfigurationLookupDtoBase, new()
    where TCreateUpdateDto : class, IConfigurationLookupCreateUpdateDto, new()
    where TAppService : ICrudAppService<TDto, Guid, PagedAndSortedResultRequestDto, TCreateUpdateDto, TCreateUpdateDto>
{
    protected IReadOnlyList<TDto> Items { get; set; } = Array.Empty<TDto>();

    protected bool IsLoading { get; set; }

    protected Modal? EditModal { get; set; }

    protected TCreateUpdateDto EditingEntity { get; set; } = new();

    protected Guid EditingId { get; set; }

    [Parameter]
    public string EntityName { get; set; } = string.Empty;

    [Parameter]
    public string EntityNamePlural { get; set; } = string.Empty;

    protected string ModalTitle => (EditingId == Guid.Empty ? "Create " : "Edit ") + EntityName;

    protected TAppService AppService { get; set; } = default!;

    protected override async Task OnInitializedAsync()
    {
        AppService = LazyServiceProvider.LazyGetRequiredService<TAppService>();
        await LoadAsync();
    }

    protected virtual async Task LoadAsync()
    {
        IsLoading = true;
        var result = await AppService.GetListAsync(new PagedAndSortedResultRequestDto
        {
            MaxResultCount = 1000
        });
        Items = result.Items;
        IsLoading = false;
    }

    protected virtual async Task OpenCreateModalAsync()
    {
        EditingId = Guid.Empty;
        EditingEntity = new TCreateUpdateDto();
        await ShowModalAsync();
    }

    protected virtual async Task OpenEditModalAsync(Guid id)
    {
        var dto = await AppService.GetAsync(id);
        EditingId = id;
        EditingEntity = MapToCreateUpdate(dto);
        await ShowModalAsync();
    }

    protected virtual TCreateUpdateDto MapToCreateUpdate(TDto dto)
    {
        return ObjectMapper.Map<TDto, TCreateUpdateDto>(dto);
    }

    protected virtual async Task SaveAsync()
    {
        if (EditingId == Guid.Empty)
        {
            await AppService.CreateAsync(EditingEntity);
        }
        else
        {
            await AppService.UpdateAsync(EditingId, EditingEntity);
        }

        await CloseModalAsync();
        await LoadAsync();
    }

    protected virtual async Task DeleteAsync(Guid id)
    {
        await AppService.DeleteAsync(id);
        await LoadAsync();
    }

    protected virtual async Task ShowModalAsync()
    {
        if (EditModal != null)
        {
            await EditModal.Show();
        }
    }

    protected virtual async Task CloseModalAsync()
    {
        if (EditModal != null)
        {
            await EditModal.Hide();
        }
    }
}
