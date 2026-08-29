# TKH Fortress Capstone

A Terraform project that provisions a small AWS web-server environment (VPC, public subnet, security group, and EC2 instance) behind an automated CI security gate. Built as a capstone project to demonstrate Infrastructure as Code alongside DevSecOps practices.

## Architecture

`main.tf` provisions the following AWS resources:

* **VPC (`aws_vpc.tkh_fortress`):** A `10.0.0.0/16` network (CIDR configurable via `var.vpc_cidr`).
* **Internet Gateway:** Attached to the VPC for public internet access.
* **Public Subnet (`Public-Courtyard`):** `10.0.1.0/24`, with `map_public_ip_on_launch` enabled so the web server gets a public IP.
* **Route Table:** Routes `0.0.0.0/0` traffic through the Internet Gateway.
* **Security Group (`web-server-sg`):**
  * Allows inbound HTTP (80) from anywhere.
  * Allows inbound SSH (22) restricted to a single IP (`var.my_ip`).
  * Allows outbound access needed for package installs.
* **EC2 Instance:** The latest Amazon Linux 2023 AMI, hardened with `http_tokens = "required"` (IMDSv2 enforced) and an encrypted root volume, running `httpd` via user data.

All hardcoded values (region, CIDR blocks, instance type, allowed SSH IP) are externalized into `variables.tf`. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your own values before running Terraform.

---

## Getting Started

### Prerequisites

* AWS credentials configured locally.
* A `terraform.tfvars` file (created from `terraform.tfvars.example`) with at least `my_ip` set to your own IP in `/32` format.

### Deployment Steps
1. Initialize project plugins:
   ```bash
   terraform init

```

2. Review proposed changes:
```bash
terraform plan

```


3. Deploy the infrastructure:
```bash
terraform apply

```



---

## CI Security Pipeline

Every push to `main` triggers `.github/workflows/security-gate.yml`, an "Infrastructure Security Gate" that runs Trivy (using the former `tfsec` ruleset) against the Terraform code before it is trusted:

```yaml
- name: SAST Quality Gate (Trivy/tfsec)
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: 'config'
    format: 'table'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'

```

### Static Analysis Behavior

This is a static analysis scan — it reads the Terraform source and checks it against known misconfiguration patterns (open security groups, unencrypted disks, missing IMDSv2 enforcement, etc.).

> **Note:** It never touches live AWS. It confirms a setting is present and correctly written, but cannot verify runtime behavior once deployed (for example, it cannot verify that a KMS key's resource policy grants proper service permissions).

Setting `exit-code: '1'` converts this from a passive report into an enforced gate: any **CRITICAL** or **HIGH** finding fails the build instead of just logging it.

### Inline Suppressions

Two findings in this codebase are intentionally accepted rather than fixed, and are suppressed inline with a reason:

1. **`AVD-AWS-0164` (Public IP on the subnet):** Required because this subnet hosts the public-facing web server.
2. **`AVD-AWS-0104` (Unrestricted egress):** Required so the instance can reach AWS package repos via `yum`.

---

## Milestones

* **Milestone 1:** Externalized hardcoded values into `variables.tf` and added a `terraform.tfvars.example` template.
* **Milestone 2:** Added the CI security pipeline (Trivy/tfsec quality gate) to `main`.
EOF

git add README.md && git commit -m "docs: rewrite README with full technical details" && git push

```

```
