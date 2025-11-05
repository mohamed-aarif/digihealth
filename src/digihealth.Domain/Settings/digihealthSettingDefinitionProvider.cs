using Volo.Abp.Settings;

namespace digihealth.Settings;

public class digihealthSettingDefinitionProvider : SettingDefinitionProvider
{
    public override void Define(ISettingDefinitionContext context)
    {
        //Define your own settings here. Example:
        //context.Add(new SettingDefinition(digihealthSettings.MySetting1));
    }
}
