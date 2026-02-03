# ECS Memos Deployment

## Overview
Production-grade containerised application deployment on AWS using Docker, Terraform, and GitHub Actions CI/CD.

**Live Demo:** https://tm.abdulqayoom.co.uk

https://github.com/salim1704/ECS-Project/blob/main/attachments/memos-demo.mp4


**Key Features:**
- Infrastructure as Code (Terraform)
- Multi-Stage Docker Image
- Automated CI/CD (GitHub Actions + OIDC)
- ECS Fargate service running tasks in private subnets
- High availability (Multi-AZ)

---

## Architecture

<img width="1387" height="935" alt="image" src="https://github.com/user-attachments/assets/b9c972c6-78c5-4ad2-a66b-a64bbd5daee6" />


**Infrastructure:**
- **Compute:** ECS Fargate (serverless containers)
- **Networking:** VPC with public/private subnets across 2 AZs
- **VPC Endpoints** for private AWS service access (no NAT Gateway required)
- **Load Balancing:** Application Load Balancer with HTTPS
- **Security:** Private subnets, security groups, VPC endpoints
- **DNS/SSL:** Route 53 + ACM certificate
- **Registry:** Amazon ECR
- **State:** S3 backend with versioning and DynamoDB state locking

---

## Repository Structure
```
ECS-PROJECT
├── docker/                      # Dockerfile
├── terraform-bootstrap/         # S3 state bucket + DynamoDB lock table
├── terraform/                   # Infrastructure (modular)
│   └── modules/                 # vpc, alb, ecs, ecr, etc.
├── .github/workflows/           # CI/CD pipelines
│   ├── deploy.yaml              # Build & push Docker
│   ├── apply.yaml               # Provision infrastructure
│   ├── health-check.yaml        # Post-deployment validation
│   └── destroy.yaml             # Teardown
└── README.md
```

---

## Local Setup

**1. Clone the repository:**
```bash
git clone https://github.com/salim1704/ECS-Project.git
cd ECS-Project
```

**2. Build the Docker image:**
**Note: Docker Desktop must be running and you must be logged in**
```bash
docker build -t memos-app:local -f docker/Dockerfile .
```

**3. Run the container:**
```bash
docker run -d -p 8081:8081 --name memos memos-app:local
```

**4. Access the application:**
```bash
http://localhost:8081
```

---

## Build Process

### Prerequisites
- AWS Account + CLI configured
- Terraform >= 1.6.0
- Docker Desktop
- GitHub account
- Registered Domain

**1. Containerisation**

- Containerised the Memos application using a multi-stage Dockerfile
- Reduced image size from ~1.44GB to ~99MB through multi-stage builds and layer caching
- Tested the container locally on port 8081

<img width="1568" height="315" alt="Screenshot 2026-01-27 090032" src="https://github.com/user-attachments/assets/5a5fd996-2aed-4e9d-b620-0316f1be213d" />

**2. AWS Manual Setup (ClickOps)**

- Created ECR repository and pushed initial image
- Built infrastructure manually in AWS Console to understand services
- Deployed VPC, subnets, security groups, ALB, ECS cluster
- Configured ACM certificate and Route 53 DNS records
- Tested full flow end-to-end

**3. Infrastructure as Code (Terraform)**

- Destroyed manual resources after validation
- Rebuilt the entire stack using modular Terraform (VPC, ALB, ECS, IAM, Route 53, ACM, ECR, endpoints)
- Implemented remote state storage in S3 using a bootstrap workflow
- Added DynamoDB state locking to prevent concurrent Terraform operations
- Configured VPC endpoints for ECR, S3, CloudWatch Logs, and STS, removing the need for a NAT Gateway

**4. CI/CD Automation**

- Infrastructure provisioning is triggered manually via a Terraform Apply workflow
- On successful apply, downstream workflows are triggered automatically using `workflow_run`
- Deployment pipeline:
  - Build Docker image
  - Security scan with Trivy
  - Push image to Amazon ECR (`latest` + commit SHA)
  - Force new ECS deployment to roll tasks in-place (service is not recreated)
- A post-deployment health check workflow runs automatically to validate the live endpoint with retries

#### Workflows
- **apply.yaml** (manual): Terraform init → validate → plan → apply
- **deploy.yaml** (automatic): Triggered on successful apply; builds, scans, and deploys the application
- **health-check.yaml** (automatic): Runs after deployment to validate application availability
- **destroy.yaml** (manual): Tear down infrastructure
  
<img width="1422" height="376" alt="Screenshot 2026-02-02 193142" src="https://github.com/user-attachments/assets/6a2a2d31-0e21-47b3-ae56-201178fbffc4" />

---

## Architecture Highlights

**Network:**
- VPC (10.0.0.0/16) with 2 public + 2 private subnets
- Internet Gateway for public access
- VPC endpoints for AWS services (no NAT Gateway)

**Security:**
- ECS tasks in private subnets (no public IPs)
- Security groups with least-privilege
- HTTPS enforced (ACM certificate)
- GitHub OIDC authentication

**High Availability:**
- Multi-AZ deployment
- ALB health checks
- Auto-healing ECS service

**State Management:**
- S3 backend with versioning for state storage
- DynamoDB table for state locking
- Prevents concurrent Terraform operations

---

## Tech Stack

- **Cloud:** AWS (ECS, ECR, ALB, VPC, Route 53, ACM, S3, CloudWatch, DynamoDB)
- **IaC:** Terraform
- **Containers:** Docker
- **CI/CD:** GitHub Actions
- **Auth:** AWS OIDC

---

## Lessons Learned

- Importance of separating infrastructure provisioning from application deployment
- ECS services require image availability before task creation
- VPC endpoints removed NAT Gateway dependency and cost
- Bootstrap + remote state avoids Terraform drift
- State locking prevents concurrent modification issues


**Best Practises:**
- Modular Terraform for reusability
- Multi-stage Docker builds with layer caching
- Separate workflows for infrastructure vs. application
- Private subnets with VPC endpoints
- OIDC authentication for CI/CD
- State locking for safe concurrent operations
- Manual infrastructure changes, automated deployments


