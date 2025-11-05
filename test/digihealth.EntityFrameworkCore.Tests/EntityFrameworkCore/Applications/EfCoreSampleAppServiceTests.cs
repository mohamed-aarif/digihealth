using digihealth.Samples;
using Xunit;

namespace digihealth.EntityFrameworkCore.Applications;

[Collection(digihealthTestConsts.CollectionDefinitionName)]
public class EfCoreSampleAppServiceTests : SampleAppServiceTests<digihealthEntityFrameworkCoreTestModule>
{

}
