using digihealth.Samples;
using Xunit;

namespace digihealth.EntityFrameworkCore.Domains;

[Collection(digihealthTestConsts.CollectionDefinitionName)]
public class EfCoreSampleDomainTests : SampleDomainTests<digihealthEntityFrameworkCoreTestModule>
{

}
