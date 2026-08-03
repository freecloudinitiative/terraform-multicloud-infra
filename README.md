# Multi-Cloud Terraform Automation for Free Cloud Initiative

This repository contains independent Terraform configurations for provisioning Google Cloud Platform (**GCP**), Microsoft Azure (**Azure**), or Amazon Web Services (**AWS**) compute instances and network security rules.

---

## Local Usage

### 1. Provision GCP Cluster

```bash
cd gcp

export TF_VAR_project_id="your-gcp-project-id"
export TF_VAR_admin_ip_ranges="[\"$(curl -s https://ipinfo.io/ip)/32\"]"

terraform init -backend-config="bucket=tf-state-$TF_VAR_project_id"
terraform plan
terraform apply
```

### 2. Provision Azure Cluster

```bash
cd azure

export TF_VAR_admin_ip_ranges="[\"$(curl -s https://ipinfo.io/ip)/32\"]"

terraform init -backend-config="bucket=tf-state-your-gcp-project-id"
terraform plan
terraform apply
```

### 3. Provision AWS Cluster

```bash
cd aws

export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"

terraform init -backend-config="bucket=tf-state-your-gcp-project-id"
terraform plan
terraform apply
```

---

## GitHub Actions Workflows

The workflows include a **Target Cloud / Infrastructure Provider** choice input (`gcp`, `azure`, `aws`):

1. **Terraform PR Check**: Validates syntax and runs `terraform validate` across `./gcp`, `./azure`, and `./aws`.
2. **Terraform Apply**: Runs manually via GitHub UI, prompting you to select the target provider directory.
3. **Terraform Destroy**: Runs manually via GitHub UI to tear down resources on the selected provider/directory.

### Required Secrets

- **GCP Secrets**: `GCP_PROJECT_ID`, `GCP_SA_KEY`, `ADMIN_IP_RANGES`
- **Azure Secrets**: `AZURE_CREDENTIALS`
- **AWS Secrets**: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
