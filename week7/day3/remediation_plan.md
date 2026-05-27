# CLOUDNANO REMEDIATION PLAN

**Operator:Sefat E Monzor **
 ## TOP 5 CRITICAL FIXES
*(From the 20 raw findings, select the 5 that pose the greatest ACTUAL risk. Explain your reasoning.)*

1. **[CVSS 9.8] Remote Code Execution in Apache Struts (Internet Facing Web Server)**
   * **Justification:** Critical impact and high likelihood because an attacker can exploit this internet-facing server to gain total system takeover and establish an initial foothold for lateral network movement.

2. **[CVSS 9.8] Unauthenticated AWS S3 Bucket (Contains Customer PII)**
   * **Justification:** High likelihood due to public internet exposure combined with severe impact from the immediate, unauthorized exposure of sensitive customer PII and resulting legal compliance failures.

3. **[CVSS 8.1] SQL Injection in Login Page (Customer Database Portal)**
   * **Justification:** High impact because it allows direct, massive exfiltration of customer credentials and database records from a critical, public-facing entry point.

4. **[CVSS 8.8] Cross-Site Scripting (XSS) on Support Forum**
   * **Justification:** Moderate threat vector that presents a realistic likelihood for the hijacking of active user sessions, though it ranks below direct database compromises in total business impact.

5. **[CVSS 9.0] SMBv1 Enabled (Internal HR File Server)**
   * **Justification:** High impact because utilizing an outdated, vulnerable protocol on an HR asset creates an active entry vector for internal ransomware propagation and sensitive data theft.


