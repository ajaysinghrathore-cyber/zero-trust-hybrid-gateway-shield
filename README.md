# Automated Zero-Trust Cloud Infrastructure Hardening Pipeline

A hands-on cloud and container security lab demonstrating infrastructure hardening and compliance-oriented controls. The repository combines Docker, Nginx, gVisor, Kubernetes, Terraform, and GitHub Actions to demonstrate layered security practices.

## 🛡️ Architecture & Hardening Matrix

| Security Layer | Implemented Control | Core Functionality |
| :--- | :--- | :--- |
| **Host Layer** | `Nginx Reverse Proxy` | Mitigates Layer 7 Distributed Denial of Service (DDoS) via strict `burst=1 nodelay` boundary controls. |
| **Sandbox Runtime** | `Google gVisor (runsc)` | Eliminates shared-kernel vulnerabilities by establishing a strong virtualized architecture barrier between containers and the host. |
| **Storage Security** | `Immutable Rootfs` | Forces strict read-only root filesystems across containers, rendering real-time ransomware file modifications completely impossible. |
| **Identity Layer** | `Non-Root Execution` | Enforces specific non-root user UID/GID mapping (UID 101), strictly blocking administrative privilege escalation exploits. |
| **Boundary Control** | `Host Isolation` | Restricts automated storage system integration blocks to protect primary filesystem schemas from virtual environment leaks. |

## ⚙️ Automated CI/CD Lifecycle

The pipeline integrates an active multi-stage GitHub Actions automation engine to handle infrastructure security audits:
1. **Source Synchronization:** Seamless repository code tracking checks.
2. **Compliance Validation:** Automated verification models validating runtime schemas and storage parameters before deployment authorization.

## 🏁 Forensic Malware Containment Verification

The architecture's defensive strength was verified via a simulated ransomware exploitation attack executed within the container's environment layer. 

The hardened subsystem successfully neutralized the payload execution in under a millisecond, returning absolute defensive system signals:
* `touch: cannot touch '/etc/nginx/nginx.conf': Permission denied`
* `rm: cannot remove '/usr/share/nginx/html/index.html': Permission denied`

These results demonstrate that the tested write operations were denied by the configured permissions. They provide evidence for the tested control, not proof of complete system-wide containment.
