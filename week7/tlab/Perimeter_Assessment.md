# TITANCORP: PERIMETER ASSESSMENT REPORT
**Operator:** **Target Subnet:** 172.88.0.0/24

## PHASE 1: ACTIVE ENUMERATION (NMAP)
*(List the live IPs discovered and their running services/versions)*
* **Host 1 ([172.88.0.10]):** [Running nginx 1.14.2 on Port 80 (Web Server 1)]
* **Host 2 ([172.88.0.15]):** [All 1000 ports are closed / ignored states.]
* **Host 3 ([172.88.0.20]):** [Running Apache httpd 2.4.67 on Port 80 (Web Server 2)]

## PHASE 2: VULNERABILITY AUDIT (NIKTO)
*(Run Nikto against the TWO web servers discovered above. List one major finding for each.)*
* **Web Server 1 Finding:** [The anti-clickjacking X-Frame-Options header is not present on 172.88.0.10, exposing users to UI redressing attacks.]
* **Web Server 2 Finding:** [HTTP TRACE method is active (OSVDB-877) on 172.88.0.20, which suggests the host is vulnerable to Cross-Site Tracing (XST) attacks.]

## PHASE 3: RISK TRIAGE
*(Review your findings. Identify the SINGLE highest-risk vulnerability across the entire DMZ. Justify why it is the top priority using the Likelihood x Impact formula.)*

* **Top Priority Remediation:** [Upgrade Outdated Nginx Web Server (Version 1.14.2) on 172.88.0.10.]
* **Justification:** [This finding is our top priority because the likelihood of exploitation is extremely high due to well-known public vulnerabilities in this 2018 software version, and the impact is critical because it could allow an external attacker to compromise an internet-facing host.]
