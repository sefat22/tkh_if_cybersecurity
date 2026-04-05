# 🛡️ Cybersecurity Foundations: Linux & Systems Security

## T1-M1: Python Orchestration & System Auditing
**Documentation of automated security scripts and process monitoring labs.**

## 📅 Module 1, Day 9: The Conductor — Automated System Auditing

### 📁 Project Overview
This phase focused on **System Orchestration** using Python. The mission was to move beyond manual terminal commands and build an automated "Security Guard" (`system_auditor.py`). The script programmatically audits system processes, identifies unauthorized cryptominers, and generates machine-readable alerts (JSON) for incident response teams.

### 🛠️ Tasks & Achievements
* **Subprocess Integration:** Leveraged the `subprocess` module to execute low-level OS commands (`ps aux`) directly from a Python environment.
* **Data Transformation:** Successfully decoded raw system bytes into UTF-8 strings, ensuring the audit data was human-readable and searchable.
* **Threat Detection Logic:** Engineered a conditional search algorithm to scan system snapshots for specific unauthorized process signatures.
* **Alert Serialization:** Automated the generation of a `security_alert.json` file, translating Python data structures into standardized JSON format for SOC integration.

### 🧠 Key Technical Competencies

| Tool / Concept | Purpose in Security |
| :--- | :--- |
| **Subprocess** | Acts as a bridge between Python and the OS; essential for automating CLI tools. |
| **stdout (Standard Out)** | Capturing the "voice" of the computer to analyze system state programmatically. |
| **Data Decoding** | Converting raw binary data (bits) into text to prevent forensic misinterpretation. |
| **JSON Serialization** | Creating portable, structured logs that can be ingested by SIEM tools. |
| **Conditional Logic** | Automating the "Decision Engine" to trigger alerts only when threats are present. |

### 🚧 Challenges & Resolutions

* **Issue:** Captured output appeared as raw bytes (e.g., `b'output'`), causing search strings to fail.
* **Root Cause:** Python's `subprocess` captures raw binary data by default to preserve accuracy.
* **Resolution:** Implemented `text=True` within the `subprocess.run` command to force the interpreter to decode the data into a readable string.

* **Issue:** Python script crashed when trying to export the alert.
* **Root Cause:** Attempted to use `json.dump` without importing the necessary library.
* **Resolution:** Added `import json` to the header of the script to provide Python with the tools needed for data translation.

### 📂 Portfolio Artifacts
* **system_auditor.py**: The primary automation engine.
* **security_alert.json**: The generated forensic report.

