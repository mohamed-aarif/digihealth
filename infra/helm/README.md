# DigiHealth Helm Charts (per-service) — Ready for ArgoCD

Each folder is a simple Helm chart for one microservice. Values are production-friendly defaults and can be overridden by environment overlays or ArgoCD `values`.

## Services
identity, patient, records, consent, doctor, iot (consumer), ai-gateway, interop, search

## Common usage
```bash
# example: deploy the 'records' chart into namespace 'records'
helm upgrade --install records ./records -n records --create-namespace

# with custom values
helm upgrade --install records ./records -n records -f values.prod.yaml
```
