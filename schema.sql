-- ============================================================
-- Support Ticket Analyzer — schema.sql
-- Author: Vamsy | Marthala Vamsidhar Reddy
-- Description: 3NF-normalised schema for support ticket analytics
-- ============================================================

-- Drop tables if they exist (for clean re-runs)
DROP TABLE IF EXISTS ticket_assignments;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS agents;

-- ─── AGENTS TABLE ───────────────────────────────────────────
CREATE TABLE agents (
    agent_id    SERIAL PRIMARY KEY,
    agent_name  VARCHAR(100) NOT NULL,
    region      VARCHAR(50),
    team        VARCHAR(50)
);

-- ─── TICKETS TABLE ──────────────────────────────────────────
CREATE TABLE tickets (
    ticket_id     SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    product       VARCHAR(100) NOT NULL,
    priority      VARCHAR(20)  CHECK (priority IN ('P1','P2','P3','P4')),
    status        VARCHAR(20)  CHECK (status IN ('open','in_progress','resolved','closed')),
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    resolved_at   TIMESTAMP,
    csat_score    SMALLINT     CHECK (csat_score BETWEEN 1 AND 5)
);

-- ─── TICKET ASSIGNMENTS TABLE (junction — M:N) ──────────────
CREATE TABLE ticket_assignments (
    assignment_id SERIAL PRIMARY KEY,
    ticket_id     INT NOT NULL REFERENCES tickets(ticket_id),
    agent_id      INT NOT NULL REFERENCES agents(agent_id),
    assigned_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ─── INDEXES ────────────────────────────────────────────────
CREATE INDEX idx_tickets_product    ON tickets(product);
CREATE INDEX idx_tickets_created_at ON tickets(created_at);
CREATE INDEX idx_tickets_status     ON tickets(status);
CREATE INDEX idx_assignments_agent  ON ticket_assignments(agent_id);
