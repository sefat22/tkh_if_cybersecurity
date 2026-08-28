# TLAB 10: Cloud Compliance Audit

**Module:** Phase 2 — Cloud Security Engineering | Sprint 5 (Governance & Compliance)
**Role:** External Cloud Auditor, Titan FinTech (simulated engagement)

## Overview

This lab simulates a compliance audit of a FinTech company's AWS environment. Using Terraform, I deployed AWS Config — a continuous monitoring service — along with two compliance rules, and intentionally misconfigured resources to trigger them. I then investigated, remediated, and verified the fixes, and delivered the findings as a business-facing executive report rather than a technical writeup.

The goal wasn't just to fix a vulnerability — it was to prove detection worked, fix the root cause, and translate the risk into terms a non-technical executive could act on.

## What Was Deployed

Using Terraform (`main.tf`):

- **AWS Config Recorder** — continuously tracks the configuration state of AWS resources in the account.
- **Two AWS Config Rules:**
  - `restricted-ssh` (`INCOMING_SSH_DISABLED`) — flags any security group allowing SSH (port 22) from `0.0.0.0/0`.
  - `s3-bucket-public-read-prohibited` (`S3_BUCKET_PUBLIC_READ_PROHIBITED`) — flags any S3 bucket configured to allow public read access.
- **Intentionally vulnerable resources**, planted to trigger the rules above:
  - A security group (`vulnerable-ssh-access`) with SSH open to the entire internet.
  - An S3 bucket with its public access block settings disabled.
- **Supporting infrastructure** — an IAM role granting Config permission to operate, and a separate S3 bucket for Config's delivery logs.

## Process

1. **Deploy** — `terraform init` / `terraform apply` to provision the recorder, rules, and vulnerable resources.
2. **Trigger** — waited for AWS Config to evaluate the environment; confirmed both rules reported **Noncompliant**.
   - Note: disabling an S3 bucket's public access block does not by itself make it publicly readable — it only removes the guardrail preventing that. To get an accurate Noncompliant finding, I added a bucket policy explicitly granting public read access, matching how this misconfiguration actually happens in production.
3. **Remediate:**
   - Removed the `0.0.0.0/0` inbound SSH rule from the security group.
   - Removed the public-read bucket policy and re-enabled "Block all public access" on the S3 bucket.
4. **Verify** — re-evaluated both Config rules and confirmed they returned to **Compliant**.
5. **Report** — wrote a one-page executive memo translating both findings into business risk (unauthorized access / ransomware exposure, and data-leak / regulatory-fine exposure), and mapped the response to the NIST Cybersecurity Framework.
6. **Teardown** — `terraform destroy` to remove all resources and stop AWS Config evaluation billing.

## NIST CSF Alignment

| Function | Action Taken |
|---|---|
| **Detect** | Deployed AWS Config to continuously monitor for configuration drift against security policy. |
| **Protect** | Removed the open SSH ingress rule and re-enabled the S3 public access block. |
| **Verify / Recover** | Re-ran Config's evaluation to confirm both findings returned to a Compliant state. |

## Deliverables

- `main.tf` — Terraform configuration for the audit environment.
- `Executive_Audit_Report.pdf` — one-page business-risk memo to the (fictional) CEO of Titan FinTech.
- `TLAB-10 Pre-Remediation SS.png` — AWS Config dashboard showing both rules Noncompliant.
- `TLAB - Post-Remediation SS.png` — AWS Config dashboard showing both rules Compliant after remediation.

## Key Takeaway

The technical fix here was simple — delete a firewall rule, flip a permission switch. The harder part of this lab was the translation layer: explaining *why* an open SSH port or a misconfigured bucket matters to someone whose job is running a business, not reading Terraform. A vulnerability that never gets communicated in terms leadership can act on might as well not have been found.
