#!/bin/bash
# T1-M1-S02: SECURITY HARDENING AUTOMATION
# Task: Restore Gold Standard permissions to restricted artifacts.



# TODO: Add commands to secure ~/Vault/secrets.txt to 600
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# TODO: Add commands to secure /etc/shadow to 640
chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow
