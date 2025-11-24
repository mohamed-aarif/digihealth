using System;
using System.Collections.Generic;

namespace PatientService;

public class PatientServiceSeedOptions
{
    public List<Guid> IdentityPatientIds { get; set; } = new();
}
