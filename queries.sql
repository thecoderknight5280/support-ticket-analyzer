-- ============================================================
-- Support Ticket Analyzer — queries.sql
-- 10 analytical queries for portfolio demonstration
-- ============================================================

-- ─── QUERY 1: MTTR per Product ───────────────────────────────
-- "Which product takes longest to resolve?"
SELECT
    product,
    COUNT(*)                                          AS total_tickets,
    ROUND(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600), 2) AS avg_resolution_hrs
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY product
ORDER BY avg_resolution_hrs DESC;

-- ─── QUERY 2: CSAT Score by Priority ─────────────────────────
-- "Do higher-priority tickets get better satisfaction ratings?"
SELECT
    priority,
    COUNT(*)                        AS tickets,
    ROUND(AVG(csat_score), 2)       AS avg_csat,
    MIN(csat_score)                 AS min_csat,
    MAX(csat_score)                 AS max_csat
FROM tickets
WHERE csat_score IS NOT NULL
GROUP BY priority
ORDER BY priority;

-- ─── QUERY 3: Agent Workload ──────────────────────────────────
-- "How many tickets has each agent handled?"
SELECT
    a.agent_name,
    a.team,
    a.region,
    COUNT(ta.ticket_id)             AS tickets_handled
FROM agents a
LEFT JOIN ticket_assignments ta ON a.agent_id = ta.agent_id
GROUP BY a.agent_id, a.agent_name, a.team, a.region
ORDER BY tickets_handled DESC;

-- ─── QUERY 4: Overdue Open Tickets (> 7 days) ─────────────────
-- "Which tickets have been sitting unresolved for too long?"
SELECT
    t.ticket_id,
    t.customer_name,
    t.product,
    t.priority,
    t.status,
    DATE_TRUNC('day', NOW() - t.created_at) AS days_open,
    a.agent_name
FROM tickets t
JOIN ticket_assignments ta ON t.ticket_id = ta.ticket_id
JOIN agents a              ON ta.agent_id  = a.agent_id
WHERE t.status IN ('open', 'in_progress')
  AND NOW() - t.created_at > INTERVAL '7 days'
ORDER BY days_open DESC;

-- ─── QUERY 5: Monthly Ticket Volume ──────────────────────────
-- "Are ticket volumes growing month over month?"
SELECT
    DATE_TRUNC('month', created_at)::DATE   AS month,
    COUNT(*)                                AS total_tickets,
    COUNT(*) FILTER (WHERE priority = 'P1') AS p1_tickets,
    COUNT(*) FILTER (WHERE priority = 'P2') AS p2_tickets
FROM tickets
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month;

-- ─── QUERY 6: Tickets by Status Summary ──────────────────────
-- "What is the current health of our ticket queue?"
SELECT
    status,
    COUNT(*)                                          AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM tickets
GROUP BY status
ORDER BY count DESC;

-- ─── QUERY 7: Top Customers by Ticket Volume ─────────────────
-- "Which customers open the most tickets?"
SELECT
    customer_name,
    COUNT(*)                        AS total_tickets,
    COUNT(*) FILTER (WHERE priority IN ('P1','P2')) AS high_priority,
    ROUND(AVG(csat_score), 2)       AS avg_csat
FROM tickets
GROUP BY customer_name
ORDER BY total_tickets DESC
LIMIT 10;

-- ─── QUERY 8: P1 Breach Report ───────────────────────────────
-- "Which P1 tickets took longer than 8 hours to resolve (SLA breach)?"
SELECT
    ticket_id,
    customer_name,
    product,
    created_at,
    resolved_at,
    ROUND(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600, 1) AS resolution_hrs
FROM tickets
WHERE priority = 'P1'
  AND resolved_at IS NOT NULL
  AND resolved_at - created_at > INTERVAL '8 hours'
ORDER BY resolution_hrs DESC;

-- ─── QUERY 9: CSAT Distribution ──────────────────────────────
-- "How are our satisfaction scores spread?"
SELECT
    csat_score,
    COUNT(*) AS count,
    REPEAT('█', COUNT(*)::INT) AS bar
FROM tickets
WHERE csat_score IS NOT NULL
GROUP BY csat_score
ORDER BY csat_score DESC;

-- ─── QUERY 10: Agent Efficiency (MTTR per Agent) ─────────────
-- "Which agents resolve tickets fastest?"
SELECT
    a.agent_name,
    COUNT(t.ticket_id) AS resolved_tickets,
    ROUND(AVG(EXTRACT(EPOCH FROM (t.resolved_at - t.created_at)) / 3600), 2) AS avg_resolution_hrs,
    ROUND(AVG(t.csat_score), 2) AS avg_csat
FROM agents a
JOIN ticket_assignments ta ON a.agent_id  = ta.agent_id
JOIN tickets t             ON ta.ticket_id = t.ticket_id
WHERE t.resolved_at IS NOT NULL
GROUP BY a.agent_id, a.agent_name
ORDER BY avg_resolution_hrs ASC;
