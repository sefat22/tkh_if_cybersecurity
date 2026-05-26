# 📆 Week 7, Day 1: Passive Security Audit

**Scenario:** Performing a passive security audit on **CloudNano** during its acquisition by TitanCorp. The goal is to map their digital footprint completely invisibly.

---

## 📁 Project Overview

This lab focuses on **Passive Reconnaissance and OSINT**. We mapped an external attack surface using public data and third-party tools without sending a single packet to the target's servers.

---

## 🛠️ Tasks & Achievements

* **Infrastructure Shodan Filters:** Used `city:"Allentown"` and banner-grabbing queries (`port:3389`, `vsFTPd 2.3.4`) to find exposed devices and vulnerable service headers.
* **Subdomain Discovery:** Ran `sublist3r` on a proxy target (`tesla.com`) to passively uncover active subdomains.
* **Tech Stack Mapping:** Used BuiltWith to identify corporate web infrastructure components (CMS, CDN, and Backend hosting).
* **Credential Leak Analysis:** Investigated exposed corporate email structures and past database breach exposure via public OSINT concepts.

---

## 🧠 Key Technical Competencies

| Audit Phase | Tool / Method | Purpose in Security |
| :--- | :--- | :--- |
| **Global Recon** | Shodan Filters | Isolates exposed internet-facing infrastructure by location. |
| **Banner Grabbing** | Plain-text Header Queries | Identifies unpatched software versions leaking to the public. |
| **Asset Mapping** | `sublist3r` | Discovers forgotten or hidden staging and dev subdomains. |
| **Identity Audit** | Breach Tracking / Email Scraping | Evaluates targets for phishing and credential-stuffing risks. |
| **Stack Fingerprinting** | BuiltWith / Wappalyzer | Maps the CMS, CDN, and backend to find potential CVE paths. |

---

## 🚧 Challenges & Resolutions

* **Issue:** Free-tier limits or verification blocks on domain-wide email breach searches.
* **Root Cause:** Platforms require proof of ownership for full domain access to prevent malicious targeting.
* **Resolution:** Pivoted to alternative OSINT tools like Hunter.io to discover domain naming patterns and scrape public leak profiles passively.


---


# 🗺️ Operation Shadow Map: Perimeter Assessment Lab

## 📝 Project Overview
This lab focuses on **Active Reconnaissance** and **Vulnerability Auditing** of an internal subnet (`172.88.0.0/24`). The goal was to sweep the network for live hosts, identify active web applications, scan them for security flaws, and prioritize the risks for leadership.

---

## 🛠️ Tasks & Achievements

* **Subnet Sweeping:** Ran an Nmap ping sweep to discover live infrastructure assets inside the target DMZ.
* **Service Interrogation:** Conducted aggressive Nmap version scans (`-sV`) to uncover the exact software versions running on open ports.
* **Vulnerability Auditing:** Used Nikto to automatically scan the active web servers for missing security headers and dangerous configurations.
* **Risk Triage:** Prioritized vulnerabilities using the standard security formula ($\text{Risk} = \text{Likelihood} \times \text{Impact}$) to build a CISO-ready assessment report.

---

## 🧠 Key Technical Competencies

| Audit Phase | Tool / Method | Purpose in Security |
| :--- | :--- | :--- |
| **Active Recon** | `nmap -sn` | Sweeps a network subnet to see which machines are turned on. |
| **Version Detection** | `nmap -sV` | Inspects open ports to find unpatched or outdated software versions. |
| **Web Auditing** | `nikto` | Scans web servers for server misconfigurations and missing headers. |
| **Risk Triaging** | Likelihood x Impact | Determines which vulnerabilities pose the highest real-world threat. |
| **Configuration Control** | `git` / Terminal | Uses terminal commands and Git flow to document and push security artifacts. |

---

## 🚧 Challenges & Resolutions

* **The Issue:** Ran into a `fatal: Need to specify how to reconcile divergent branches` error when trying to push the final report to GitHub.
* **The Root Cause:** Changes were made directly on the remote GitHub repository last night, causing the local environment to become outdated and out of sync.
* **The Resolution:** Configured Git's merge strategy using `git config pull.rebase false`, pulled the remote changes down cleanly, and successfully pushed the completed project files.
