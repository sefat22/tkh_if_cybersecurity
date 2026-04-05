

#!/usr/bin/env python3
import subprocess
import json
import os

print("[*] Initiating System Audit...")

# Use subprocess.run() to execute 'ps aux'
process_list = subprocess.run(["ps", "aux"], capture_output=True, text=True)

# Search the captured output for the malicious process
if "unauthorized_cryptominer" in process_list.stdout:
	 alert_data = {
        "event": "Unauthorized Process",
        "severity": "High",
        "process": "unauthorized_cryptominer"
    }


# If found, create a dictionary and save it to 'security_alert.json'
with open("security_alert.json", "w") as file:
	json.dump(alert_data, file, indent=4)

print("[+] Audit Complete.")
