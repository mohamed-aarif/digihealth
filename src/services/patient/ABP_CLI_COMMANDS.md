# DigiHealth Patient Service - ABP CLI bootstrap

```bash
abp new DigiHealth.PatientService -u none -d ef -dbms PostgreSql -csf
cd DigiHealth.PatientService
abp add-module Volo.Abp.Account.Pro
```

> Re-run `abp generate-proxy` from the root whenever contracts change.
