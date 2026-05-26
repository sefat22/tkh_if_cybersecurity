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
