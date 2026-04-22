# TITAN SMALL BUSINESS SERVICES: SECURITY ARCHITECTURE DOCUMENT (SAD)
**Operator:** [Your Name]
**Date:** [Date]

## 1. Perimeter Hardening (UFW & SSH)
* **SSH Status:** [Disabled root login (PermitRootLogin no) and password-based authentication (PasswordAuthentication no) to enforce SSH-key-only access.]
* **Firewall Logic:** [Implemented a "Default Deny" policy; explicitly allowed port 22 (SSH) and port 8080 (Application) while blocking all other incoming traffic.]

## 2. The Automated Auditor (Python)
* **Script Logic:** [import os
disk_data = os.popen('df -h').read()
with open('/var/log/sys_audit.log', 'a') as log_file:
    log_file.write("\n--- SYSTEM AUDIT ---\n" + disk_data)]
* **Telemetry Path:** `/var/log/sys_audit.log`

## 3. Containerized App (Docker)
* **Network Isolation:** [Redis is isolated on a private bridge network with internal: true. No ports are mapped to the host machine, ensuring the database is only reachable by the Nginx frontend.]
* **Stack Health:** [NAME                IMAGE          COMMAND                  SERVICE    STATUS
student-backend-1   redis:latest   "docker-entrypoint.s…"   backend    running
student-frontend-1  nginx:latest   "/docker-entrypoint.s…"   frontend   running]

## 4. Executive Summary
[The Titan Small Business infrastructure is now secured through a multi-layered defense-in-depth strategy. By hardening the SSH gateway and isolating the containerized backend, we have significantly reduced the attack surface. Automated telemetry ensures continuous monitoring of system resources for proactive maintenance.]

