using System;
using System.Collections.Generic;

namespace PatientService.Data;

public class PatientServiceSeedDataOptions
{
    public Dictionary<string, Guid> IdentityPatientIds { get; set; } = new();
}
