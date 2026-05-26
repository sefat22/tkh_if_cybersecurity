# TARGET THREAT PROFILE: CloudNano 
**Classification:** Passive Security Audit
**Operator:** ## 1. Subdomain Discovery
* **Tool Used:** Sublist3r
* **Subdomains Found:** * [For tesla.com, I found 34 subdomains using sublist3r, one of the subdomain is accounts.tesla.com]
  * [Another subdomain found was billing.tesla.com]

## 2. Tech Stack Mapping 
* **Tool Used:** BuiltWith
* **Identified Technologies (CMS/CDN/Backend):** * [Tech Stack 1 - Tesla's CMS - Atlassian Cloud, Thron, Ultimate Software, Drupal, Drupal 9]
* [Tech Stack 2 - Tesla's CDN - Akamai, Akamai Global Host, CDN Js, GStatic Google Static Content]
*[Tech Stack 3 - Tesla's Backend - Nginx and Apache web servers hosted on Amazon AWS EC2 Infrastructure]
*[I have used Hunter.io to find emails associated with the target domain and used HaveIbeenpawned to check if the email had been breached or not. 

## 3. Major Exposure Points & Dangers
*(List three major exposure points discovered during your OSINT audit and explain why they are dangerous)*
1. **Subdomain Accumulation and Attack Surface Expansion:** Sublist3r successfully mapped out multiple active subdomains completely passively. This is dangerous because secondary, staging, or legacy subdomains (e.g., test environments) are frequently neglected, unpatched, or misconfigured, giving attackers a low-resistance entry point into the target's broader cloud architecture without triggering active intrusion detection systems.
2. **Infrastructure Fingerprinting via Public Tech Stacks:** Using BuiltWith revealed the exact CDNs, web hosting environments (Amazon AWS EC2), and web servers (Nginx/Apache) powering the target domain. This is dangerous because it allows threat actors to map the specific technology versions against public CVE databases, enabling them to build a highly targeted exploit strategy without ever interacting with the servers directly.
3. **Corporate Credential Exposure Vectors:** Public OSINT database tracking reveals that corporate email domains are frequently caught in historical third-party data breaches. This is dangerous because threat actors can weaponize these leaked credentials to execute highly targeted spear-phishing or credential-stuffing attacks against employees during a vulnerable corporate transition or acquisition phase.

