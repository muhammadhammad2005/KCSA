#!/bin/bash
echo "=== STRIDE THREAT MODELING ==="
echo "SPOOFING: Service account token theft, DNS spoofing -> Mitigation: RBAC, mTLS, network policies"
echo "TAMPERING: Image/config tampering -> Mitigation: Read-only FS, image verification"
echo "REPUDIATION: Lack of audit -> Mitigation: Audit logging, service account tracking"
echo "INFO DISCLOSURE: Secret exposure -> Mitigation: Least privilege, network encryption"
echo "DENIAL OF SERVICE: Resource exhaustion -> Mitigation: Resource limits, network policies"
echo "ELEVATION OF PRIVILEGE: Container escape -> Mitigation: Non-root containers, security contexts, RBAC"
