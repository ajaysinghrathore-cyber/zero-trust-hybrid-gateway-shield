# Zero-Trust Cloud Infrastructure Hardening Pipeline

A hands-on cloud and container security lab demonstrating layered hardening controls across Docker, Nginx, gVisor, Kubernetes, Terraform, and GitHub Actions.

## Architecture & controls

| Layer | Control | Evidence |
|---|---|---|
| Container | Nginx container | `Dockerfile` |
| Container hardening | Non-root execution | `Dockerfile` |
| Runtime isolation | gVisor runtime class | `kubernetes/pod.yaml` |
| Kubernetes | Non-root, read-only root filesystem, no privilege escalation, capability drop | `kubernetes/pod.yaml` |
| Infrastructure as Code | AWS security group and EC2 resource | `terraform/main.tf` |
| CI/CD security | Trivy HIGH/CRITICAL filesystem scan | `.github/workflows/deploy.yml` |

## Security controls

### Docker and Nginx
The Dockerfile uses Nginx Alpine, prepares required runtime directories and runs the process as UID 101. The container metadata exposes port 80, matching the Kubernetes manifest.

### Kubernetes
The Pod manifest declares:
- gVisor through `runtimeClassName: gvisor`
- UID/GID 101
- `runAsNonRoot: true`
- `readOnlyRootFilesystem: true`
- `allowPrivilegeEscalation: false`
- Linux capability drop: `ALL`

The manifest is a security-focused lab configuration. A real deployment also needs a configured gVisor RuntimeClass and appropriate writable mounts/configuration for Nginx.

### CI/CD
GitHub Actions checks the required security files and runs Trivy against the repository filesystem. The workflow is a CI security-validation pipeline; it should not be described as a complete production deployment pipeline.

### Terraform / AWS
Terraform defines an AWS security group and EC2 resource as infrastructure examples. The current configuration should be reviewed for AMI validity, network design and least-privilege requirements before any real deployment.

## Validation

Local tests such as denied write operations demonstrate the configured control for the tested scenario. They do not prove complete system-wide security, guaranteed ransomware prevention, guaranteed DDoS mitigation, or production readiness.

## Security flow

`Source → CI/CD → Trivy → Docker/Nginx → Hardening → gVisor → Kubernetes → Terraform/AWS → Runtime validation`

## Skills demonstrated

Docker · Nginx · Kubernetes · gVisor · Terraform · AWS · GitHub Actions · Trivy · Linux · Container Security · DevSecOps
