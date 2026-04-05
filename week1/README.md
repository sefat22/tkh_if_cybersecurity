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


cat << 'EOF' > README.md
# 🛡️ Cybersecurity Foundations: Linux & Systems Security

## T1-M1-S03: Linux Stream Editing and Automation
**📅 Module 1, Day 3: The Surgeon’s Toolkit (Grep, Sed, & Awk)**

### 📁 Project Overview
This lab focused on **Stream Editing** and **Log Analysis**. In a production environment, security logs are too massive for manual inspection. This session mastered the "Holy Trinity" of Linux text processing to filter, transform, and isolate Indicators of Compromise (IoCs) from raw web server data.

### 🛠️ Tasks & Achievements
* **Pattern Recognition:** Utilized Regular Expressions (Regex) to identify malicious patterns, specifically targeting SQL Injection attempts (`UNION SELECT`).
* **Data Pipeline Engineering:** Constructed multi-stage Command Pipelines using the pipe (`|`) operator.
* **Field Extraction:** Employed **Awk** as a formatter to isolate specific data columns (Source IPs).

### 🧠 Key Technical Competencies
```text
Tool        | Purpose in Security | Role in the Pipeline
------------|---------------------|----------------------
Grep        | Pattern Matching    | The Sieve: Filters noise.
Awk         | Field Processing    | The Formatter: Extracts columns.
Sed         | Stream Editing      | The Scalpel: Mass editing.
Pipes (|)   | Data Flow           | The Conveyor Belt: Automation.

Issue: Command execution "hangs" without returning to the prompt.
Root Cause: The awk command was executed without a specified input file or pipe.
Resolution: Used Ctrl + C and established proper data flow with |.

Issue: grep: access.log: No such file or directory.
Root Cause: Attempting to run commands from the Root (/) directory.
Resolution: Used 'cd ~' to return to the Home Directory.
