# Shop Application Threat Model

## Components:
- **Frontend**: nginx, LoadBalancer, Public (Untrusted)
- **Backend**: nginx simulating API, ClusterIP, Internal (Semi-trusted)
- **Database**: PostgreSQL, ClusterIP, Internal (Trusted)

## Trust Boundaries:
1. Internet → Frontend
2. Frontend → Backend
3. Backend → Database
4. Pod → Node
5. Namespace → Cluster

## Data Flow:
1. User request: Internet → Frontend → Backend → Database
2. Response: Database → Backend → Frontend → Internet
3. Internal communication: Frontend ↔ Backend (HTTP), Backend ↔ Database (TCP 5432)

## Data Types:
- User credentials
- Product catalog
- Orders
- Application logs

## Privilege Escalation Risks:
- Containers run as root by default
- No security context defined
- Host filesystem access not restricted
- Capabilities excessive

## Lateral Movement Risks:
- Flat network, all pods can communicate
- No micro-segmentation
- Service discovery allows enumeration

## Container Security Risks:
- Base images unscanned
- Hardcoded credentials
- No resource limits
- No admission controls
