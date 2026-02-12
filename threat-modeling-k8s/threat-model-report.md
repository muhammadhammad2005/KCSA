# Kubernetes Threat Model Report
## Architecture
- Frontend: nginx
- Backend: apache
- Database: postgres
## Trust Boundaries
1. External: Internet -> Frontend
2. App: Frontend -> Backend -> DB
3. Cluster: Pod-to-Pod
4. Node: Container-to-Host
## Critical Assets
- Customer DB
- Secrets
- Service account tokens
- Cluster infra
## Mitigations
- RBAC, Network Policies, Pod Security, Resource Limits
