# ABP CLI commands used to scaffold PatientService

```
abp new PatientService -u none -d ef -cs PostgreSQL -v 9.3.6
abp add-module Volo.Abp.EntityFrameworkCore.PostgreSql
abp add-package Volo.Abp.AspNetCore.Authentication.JwtBearer
```

Projects are placed under `src/services/patient` following the DigiHealth microservice conventions.
