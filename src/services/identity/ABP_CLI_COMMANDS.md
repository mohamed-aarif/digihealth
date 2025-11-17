# DigiHealth Identity Service - ABP CLI bootstrap

```bash
abp new DigiHealth.IdentityService -u none -d ef -dbms PostgreSql -csf
cd DigiHealth.IdentityService
abp add-module Volo.Abp.Identity
abp add-module Volo.Abp.TenantManagement
abp add-module Volo.Abp.Account.Pro.Public.Web
```

> Re-run `abp generate-proxy` from the root whenever contracts change.
