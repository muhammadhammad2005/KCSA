# Kubernetes Security Report

## Pod Security
- runAsNonRoot: true
- allowPrivilegeEscalation: false
- readOnlyRootFilesystem: true

## Network Segmentation
- Default deny
- Frontend → Backend allowed
- Backend → Database allowed
- Frontend → Database blocked

## Secrets
- DB credentials stored in secrets

## Resource Management
- Quotas and limit ranges applied

## Recommendations
- Image scanning
- Runtime security (Falco)
- RBAC with least privilege
