**OPERATION FORTRESS:** DEFENSE IN DEPTH REPORT

**Operator:** Sefat E Monzor

## LAYER 1: PERIMETER FIREWALL (iptables) 
**Objective:** Block egress to C2 Subnet 198.51.100.0/24 
**Rule Used:** sudo iptables -A OUTPUT -d 198.51.100.0/24 -j DROP

## LAYER 2: NETWORK IDS (Suricata)
**Objective:** Detect web shell execution "cmd=whoami" 
**Signature Used:** alert tcp any any -> any 80 (msg:"Adversary Web Shell Exploit Detected"; content:"cmd=whoami"; nocase; sid:1000001; rev:1;)

