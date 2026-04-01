# 🛡️ Cybersecurity Foundations: Linux & Systems Security
**T1-M1: Linux Foundations & FHS** *Documentation of progress, system configurations, and security labs.*

---

## 📅 Module 1, Day 1: Terminal Velocity & The Scavenger Hunt

### 📁 Project Overview
This phase focused on mastering the **Linux Filesystem Hierarchy Standard (FHS)**. Navigating a headless Ubuntu environment via CLI is a core competency for System Administration (**NICE Framework: OM-ADM-001**) and Incident Response.

### 🛠️ Tasks & Achievements
* **System Scavenger Hunt:** Audited system-level directories (`/etc`, `/var`, `/bin`) to locate specific configuration tokens and log files.
* **Environment Orchestration:** Established a secure **SSH Bridge** between a headless Virtual Machine and GitHub for streamlined workflow.
* **Workflow Automation:** Engineering custom **Bash Aliases** to optimize repetitive system management tasks.

### 🧠 Key Technical Competencies
| Directory | Purpose in Security |
| :--- | :--- |
| `/etc` | Critical configuration files; a primary target for persistence. |
| `/var/log` | The "black box" of the system; essential for forensic analysis. |
| `/bin` | Contains essential user binaries; monitored for unauthorized changes. |
| `/home` | User-specific data; the first line of defense for personal privacy. |

### 🚧 Challenges & Resolutions
> **Issue:** VS Code Remote-SSH instability (Connection crashes).  
> **Root Cause:** Unknown/Process hang on the remote server.  
> **Resolution:** Performed a full client-side reboot and re-established the SSH handshake, successfully clearing the buffer.

---

## 📅 Module 1, Day 2: Permissions & Access Control (In Progress)
*Working on mastering the Octal math (4-2-1) to secure system files.*
