# marlabs-multi-cloud

# 📘 Internal Blog Website - Azure Architecture Case Study

## 📌 Project Overview

This project delivers an end-to-end **Azure-native, multi-cloud-like architecture** for a scalable, secure, observable **Internal Blog Web App**, with core features:

- 🔐 User Authentication (Azure AD B2C)
- ✍️ Blog Creation & Approval Workflow
- 💬 Commenting & Real-time Chat
- 📝 Feature Request Submission

> ⚡️ Designed for **rapid scaling** from 50 to ~2,000 users within 1 month.

---

## 📈 Scaling Requirements

| Metric | Target |
|--------|--------|
| **Initial Users** | 50 |
| **Growth Rate** | +100 users/week |
| **Expected Load (1 Month)** | ~2,000 active users |

### 🚀 Scalability Design

To handle user growth efficiently, the solution uses **elastic compute**, **autoscaling**, and **event-driven workloads**:

| Component | Scaling Strategy |
|----------|------------------|
| **App Service (Frontend)** | Auto-scale based on CPU & queue length |
| **AKS (Backend APIs)** | HPA + Cluster Autoscaler for pods and nodes |
| **Azure SQL & Cosmos DB** | Auto-scale DTUs/RUs with throughput caps |
| **Redis Cache** | Scales with connection count & performance tier |
| **ACI (ML/Moderation)** | Event-driven execution only on demand |
| **App Gateway / Front Door** | Global scaling with WAF & CDN support |

---

## 🧱 Architecture Components

This architecture uses Azure-native services to simulate a **multi-cloud deployment**:

### 1. 🖥 Frontend
- **Azure App Service (Web App for Containers)** for React/Angular UI
- Deployed behind **Azure Front Door** with **WAF protection**
- **Custom domain & HTTPS with SSL** (via Key Vault or App Gateway)

### 2. 🔧 Backend API (Business Logic)
- **Azure Kubernetes Service (AKS)** with:
  - Node Pools (System/User separation)
  - Ingress Controller (NGINX or Traefik)
  - Auto-scaling: HPA for pods, Cluster Autoscaler for nodes
  - Private VNet and Azure CNI for secure networking

### 3. 🧠 Moderation/ML Tasks
- Hosted in **Azure Container Instances (ACI)** on demand
- Triggered by API / Logic Apps for ML content moderation

### 4. 🖥 Background Processing / Legacy Systems
- Hosted on **Azure Virtual Machines** for backward compatibility
- Managed via **VMSS** (for optional HA/scale)

### 5. 🗄 Data Layer
- **Azure SQL Database** – User profiles, blog metadata
- **Azure Cosmos DB** – Chat/comments (low latency)
- **Azure Redis Cache** – Improve response time for frequent reads
- **Azure Blob Storage** – Images/media uploads

---

## 🔐 Security Best Practices

| Area | Implementation |
|------|----------------|
| **Authentication** | Azure AD B2C |
| **Access Control** | RBAC on Azure resources, DevOps pipelines |
| **Secrets Management** | Azure Key Vault (linked to AKS & DevOps) |
| **Ingress Protection** | Azure WAF via Front Door or App Gateway |
| **Private Networking** | AKS in private subnet, SQL/Cosmos with private endpoints |
| **TLS/SSL** | Enforced via Front Door / App Gateway using Key Vault certs |

---

## 🔄 CI/CD Pipeline - Azure DevOps

### 📦 Build Pipeline (CI)
- Trigger: On Pull Request or Commit to `main`
- Tasks:
  - Linting & Unit Tests
  - Docker Build for API & Frontend
  - Push to Azure Container Registry (ACR)

### 🚀 Release Pipeline (CD)
- Trigger: Successful build or manual approval
- Tasks:
  - Provision Infrastructure using Terraform
  - Deploy apps to AKS, App Service, and VMs
  - Smoke Tests & Monitoring hooks

### 🔁 Rollback Strategy
| Service | Rollback Mechanism |
|---------|--------------------|
| **AKS** | `kubectl rollout undo` |
| **App Service** | Deployment slots with swap |
| **Terraform** | Versioned modules & remote state |
| **DevOps** | Manual approval gates + retry stages |

---
