using System;
using System.Threading.Tasks;
using Volo.Abp.Application.Dtos;
using Volo.Abp.Application.Services;

namespace PatientService.Meals;

public interface IMealAppService :
    ICrudAppService<
        MealDto,
        Guid,
        MealListRequestDto,
        CreateUpdateMealDto,
        CreateUpdateMealDto>
{
    Task<ListResultDto<MealDto>> GetListForPatientAsync(MealListRequestDto input);

    Task<MealDto> GetDetailAsync(Guid id);
}
