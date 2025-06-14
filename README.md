# 💰 FinTech Ledger System  
*A Learner's Project in Event-Driven Architecture, OAuth 2.0, and Microservices*
- A Containerized Spring Boot Microservice for Secure, Auditable Financial Ledger Management

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📘 Overview

This project simulates a real-world **financial transaction system** with:
- Secure **OAuth 2.0 authentication**
- A **double-entry ledger**
- **Event-driven communication** using Solace PubSub+
- Modular **microservices** for ledger handling, balance updates, and audit logging
- Optional **React dashboard** for real-time visualizations

> 🧠 **Note:** This is a *learner's project*, meant to demonstrate:
> - Backend system design
> - Authentication flows
> - Messaging/event systems
> - Microservice architecture
> - Secure, scalable patterns used in FinTech

---

## ✅ Project Goals / Learning Outcomes

| Goal # | Concept Learned                 | Feature or Task Implemented |
|--------|----------------------------------|------------------------------|
| 1️⃣     | **Authentication with OAuth 2.0** | Secure routes, token flow   |
| 2️⃣     | **JWT tokens**                  | Role-based access control    |
| 3️⃣     | **Double-entry bookkeeping**    | Ledger API with balances     |
| 4️⃣     | **Idempotent APIs**             | Prevent duplicate txns       |
| 5️⃣     | **Solace PubSub+**              | Publish-subscribe messaging |
| 6️⃣     | **Microservices**               | Ledger / Balance / Audit     |
| 7️⃣     | **PostgreSQL**                  | ACID-compliant data storage |
| 8️⃣     | **Docker & Compose**            | Deploy full system locally   |
| 9️⃣     | **React + Tailwind** *(optional)* | Real-time UI dashboard      |
| 🔟     | **CI/CD and Logs** *(optional)*  | For monitoring and health    |

---

## 🧱 Tech Stack

| Layer         | Tools / Tech                              |
|---------------|--------------------------------------------|
| **Backend API**   | Spring Boot OR FastAPI / Node.js            |
| **Messaging**     | Solace PubSub+ (Cloud or Docker broker)     |
| **Auth**          | OAuth 2.0 + JWT (Auth0 / Keycloak / DIY)    |
| **Database**      | PostgreSQL                                  |
| **Frontend UI**   | React + TailwindCSS *(Optional)*            |
| **Infrastructure**| Docker + Docker Compose                     |

---

## 🗂️ Project Structure
fintech-ledger/
│
├── ledger-api/ → Accepts transactions, validates auth
├── balance-service/ → Updates account balances via events
├── audit-service/ → Logs all transactions for compliance
├── solace-config/ → Solace broker setup + subscriptions
├── frontend/ (optional) → React dashboard
├── docker-compose.yml → Orchestrates services
└── README.md → This file

---

## 🧪 Feature Checklist

### ✅ Phase 1: Authentication & User Management (OAuth 2.0)
- [ ] Integrate **OAuth 2.0** for login (Auth0 / Keycloak / custom)
- [ ] Validate incoming JWT tokens
- [ ] Enforce **role-based access control**
- [ ] Issue refresh tokens (optional)

### ✅ Phase 2: Ledger System (Double-Entry Bookkeeping)
- [ ] Design **accounts** and **ledger_entries** tables
- [ ] Implement `/transaction` API
  - Must debit one account and credit another
- [ ] Add **reason**, **timestamp**, and **transaction ID**
- [ ] Store all ledger entries in PostgreSQL
- [ ] Ensure **idempotency** via transaction hash or unique ID

### ✅ Phase 3: Messaging Layer (Event-Driven Architecture)
- [ ] Set up **Solace PubSub+** locally or via cloud
- [ ] Create `ledger.transaction.created` topic
- [ ] Ledger API publishes new transactions as events
- [ ] **Balance Service** listens, updates running totals
- [ ] **Audit Service** listens, logs event to DB or CSV

### ✅ Phase 4: Balance Microservice
- [ ] Subscribe to transaction events
- [ ] Keep user balances in sync
- [ ] Allow `/balance/{account_id}` API for current state

### ✅ Phase 5: Audit Logger
- [ ] Log every transaction to DB
- [ ] Track when it was received and processed
- [ ] Optionally simulate **event replay** or **dead-letter queue**

### ✅ Phase 6: Optional Dashboard (React)
- [ ] View balances and transactions in real-time
- [ ] Subscribe to updates via WebSocket / polling
- [ ] Filter by account, amount, date
- [ ] Export CSV of transactions

### ✅ Phase 7: DevOps & Deployment
- [ ] Write a `docker-compose.yml` for local dev
- [ ] Include Postgres, Solace, backend(s), frontend
- [ ] Add `.env` files for secrets and service configs
- [ ] Optionally add CI/CD pipeline (GitHub Actions / Railway)

---

## 🔐 OAuth & Security Notes

- Use `Authorization: Bearer <token>` in headers
- Validate:
  - Expiration
  - Roles (`user`, `admin`)
- Protect all write routes (e.g., posting transactions)
- Add custom middleware to enforce scopes

---

## 🧠 Key Concepts Explained

| Concept      | Real-World Analogy                 | Why It Matters                   |
|--------------|-------------------------------------|----------------------------------|
| Ledger       | Notebook of income/outcome         | Ensures every dollar is tracked |
| OAuth 2.0    | Wristbands at a VIP event           | Secure user access               |
| JWT          | Your identity + role in a token     | Stateless, fast authorization    |
| Solace       | Office intercom or postal system    | Enables async event handling     |
| Idempotency  | One receipt per purchase            | Prevents double-processing       |
| Microservices| Clerks in separate offices          | Scalability + separation         |
| Docker       | Bento box for your app              | Same setup across all systems    |

---

## 📈 Future Ideas / Power-Ups

- [ ] Add **multi-currency support** using exchange rates
- [ ] Build a **notification service** to email on large transfers
- [ ] Add **rate limiting** to prevent abuse
- [ ] Store **ledger snapshots** for fast balance lookup

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
