## 📅 Week 9, Day 1: The Data Exfiltration
**Scenario:** Active Exploitation Verification of a legacy **CloudNano** server. The mission was to bypass authentication and prove the vulnerability by extracting sensitive CEO salary data.

## 📁 Project Overview
This phase focused on **Active SQL Injection (SQLi)**. Mastering authentication bypass and UNION-based data exfiltration is a core competency for Penetration Testers (**NICE Framework: SP-RSK-001**) and Vulnerability Analysts.

## 🛠️ Tasks & Achievements
* **Authentication Bypass:** Successfully exploited a login vulnerability using a **Tautology Attack** (`' OR 1=1 --`), gaining unauthorized access to the internal directory.
* **Database Mapping:** Conducted column enumeration using the `ORDER BY` clause to identify the structure of the backend query (2 columns).
* **Schema Discovery:** Injected a `UNION SELECT` payload against `sqlite_master` to map the hidden `employees` table and identify the sensitive `salary` column.
* **Data Exfiltration:** Executed a final UNION attack to dump the CEO's salary data directly into the web interface.

## 🧠 Key Technical Competencies

| Attack Phase | Payload / Method | Purpose in Security |
| :--- | :--- | :--- |
| **Bypass** | `' OR 1=1 --` | Forcing a "True" logic statement to skip password verification. |
| **Mapping** | `' ORDER BY [N] --` | Determining the column count required for a successful UNION attack. |
| **Enumeration** | `sqlite_master` | Accessing the database's internal registry to find table names. |
| **Exfiltration** | `UNION SELECT name, salary` | Combining results from a hidden table with the visible web output. |

## 🚧 Challenges & Resolutions
**Issue:** Initial UNION payloads resulted in "Database Error" messages.  
**Root Cause:** Column mismatch; the injected SELECT statement did not match the number of columns in the original query.  
**Resolution:** Performed iterative testing with `ORDER BY` until the error cleared at 2 columns, ensuring a compatible "shape" for the UNION attack.


