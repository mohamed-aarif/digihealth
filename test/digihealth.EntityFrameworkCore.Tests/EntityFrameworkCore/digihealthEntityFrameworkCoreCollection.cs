using Xunit;

namespace digihealth.EntityFrameworkCore;

[CollectionDefinition(digihealthTestConsts.CollectionDefinitionName)]
public class digihealthEntityFrameworkCoreCollection : ICollectionFixture<digihealthEntityFrameworkCoreFixture>
{

}
