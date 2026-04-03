# Support Ticket Analyzer

**PostgreSQL · Python · psycopg2**

A relational database project that simulates how a support team tracks, assigns, and analyses support tickets — built to demonstrate real-world SQL skills in context.

---

## What It Does

- Models a 3-table, 3NF-normalised schema (tickets, agents, ticket_assignments)
- Seeds 50 realistic support tickets across 5 products and 8 agents
- Runs 10 analytical SQL queries covering MTTR, CSAT, workload, and volume trends
- Includes a Python terminal dashboard for a live summary view

---

## Setup (5 steps)

**Prerequisites:** PostgreSQL installed, psql available in terminal

```bash
# 1. Create the database
psql -U postgres -c "CREATE DATABASE support_db;"

# 2. Create tables
psql -U postgres -d support_db -f schema.sql

# 3. Load sample data
psql -U postgres -d support_db -f seed_data.sql

# 4. Run analytical queries
psql -U postgres -d support_db -f queries.sql

# 5. (Optional) Python dashboard
pip install psycopg2-binary
# Edit DB_CONFIG in dashboard.py with your credentials
python dashboard.py
```

---

## File Structure

```
support-ticket-analyzer/
├── schema.sql       — Create tables with constraints and indexes
├── seed_data.sql    — 50 mock tickets, 8 agents, assignments
├── queries.sql      — 10 analytical queries
├── dashboard.py     — Python terminal dashboard (psycopg2)
└── README.md        — This file
```

---

## Queries Included

| # | Query | SQL Concepts |
|---|-------|--------------|
| 1 | MTTR per Product | AVG, EPOCH, GROUP BY |
| 2 | CSAT by Priority | AVG, MIN, MAX, FILTER |
| 3 | Agent Workload | JOIN, COUNT, LEFT JOIN |
| 4 | Overdue Tickets (>7 days) | JOIN, INTERVAL, WHERE |
| 5 | Monthly Volume Trend | DATE_TRUNC, FILTER |
| 6 | Queue Status Summary | Window function (OVER) |
| 7 | Top Customers by Volume | GROUP BY, ORDER BY |
| 8 | P1 SLA Breach Report | INTERVAL comparison |
| 9 | CSAT Distribution | REPEAT visual bar |
| 10 | Agent Efficiency | Multi-JOIN, AVG |

---

## Schema Overview

```
tickets (ticket_id PK, customer_name, product, priority, status, created_at, resolved_at, csat_score)
    │
    └── ticket_assignments (assignment_id PK, ticket_id FK, agent_id FK, assigned_at)
                                                                │
                                                        agents (agent_id PK, agent_name, region, team)
```

---

## Author

**Vamsy | Marthala Vamsidhar Reddy**  
Senior Technical Support Specialist  
96% CSAT · 35% MTTR reduction · 50+ cases/month
