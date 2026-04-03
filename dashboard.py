"""
Support Ticket Analyzer — dashboard.py
Author: Vamsy | Marthala Vamsidhar Reddy
Requirements: pip install psycopg2-binary

Usage:
    python dashboard.py

Update DB_CONFIG below with your PostgreSQL credentials.
"""

import psycopg2
from psycopg2.extras import RealDictCursor

# ─── DB CONFIG ───────────────────────────────────────────────
DB_CONFIG = {
    "host":     "localhost",
    "port":     5432,
    "dbname":   "support_db",
    "user":     "postgres",
    "password": "your_password_here"
}

# ─── HELPERS ─────────────────────────────────────────────────
def header(title):
    print("\n" + "═" * 60)
    print(f"  {title}")
    print("═" * 60)

def run_query(cursor, sql):
    cursor.execute(sql)
    return cursor.fetchall()

# ─── MAIN DASHBOARD ──────────────────────────────────────────
def main():
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur  = conn.cursor(cursor_factory=RealDictCursor)
        print("\n✅  Connected to support_db")

        # 1. Queue Health
        header("📊  TICKET QUEUE HEALTH")
        rows = run_query(cur, """
            SELECT status,
                   COUNT(*) AS count,
                   ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
            FROM tickets GROUP BY status ORDER BY count DESC
        """)
        for r in rows:
            bar = "█" * int(r["pct"] / 5)
            print(f"  {r['status']:<14} {r['count']:>3} tickets  {bar} {r['pct']}%")

        # 2. MTTR per Product
        header("⏱  AVG RESOLUTION TIME BY PRODUCT (hours)")
        rows = run_query(cur, """
            SELECT product,
                   COUNT(*) AS resolved,
                   ROUND(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600), 1) AS avg_hrs
            FROM tickets WHERE resolved_at IS NOT NULL
            GROUP BY product ORDER BY avg_hrs DESC
        """)
        for r in rows:
            print(f"  {r['product']:<15}  {r['avg_hrs']:>6} hrs  ({r['resolved']} resolved)")

        # 3. CSAT Overview
        header("⭐  CSAT SCORE DISTRIBUTION")
        rows = run_query(cur, """
            SELECT csat_score, COUNT(*) AS count
            FROM tickets WHERE csat_score IS NOT NULL
            GROUP BY csat_score ORDER BY csat_score DESC
        """)
        for r in rows:
            stars = "★" * r["csat_score"] + "☆" * (5 - r["csat_score"])
            print(f"  {stars}  ({r['csat_score']}/5)  →  {r['count']} tickets")

        # 4. Overdue Tickets
        header("🚨  OPEN TICKETS > 7 DAYS (ACTION NEEDED)")
        rows = run_query(cur, """
            SELECT t.ticket_id, t.customer_name, t.product, t.priority,
                   EXTRACT(DAY FROM NOW() - t.created_at)::INT AS days_open,
                   a.agent_name
            FROM tickets t
            JOIN ticket_assignments ta ON t.ticket_id = ta.ticket_id
            JOIN agents a ON ta.agent_id = a.agent_id
            WHERE t.status IN ('open','in_progress')
              AND NOW() - t.created_at > INTERVAL '7 days'
            ORDER BY days_open DESC LIMIT 5
        """)
        if rows:
            for r in rows:
                print(f"  [{r['priority']}] #{r['ticket_id']:<4} {r['customer_name']:<20} "
                      f"{r['product']:<12} {r['days_open']} days  → {r['agent_name']}")
        else:
            print("  ✅  No overdue tickets!")

        # 5. Top Agent Efficiency
        header("🏆  TOP AGENTS BY RESOLUTION SPEED")
        rows = run_query(cur, """
            SELECT a.agent_name,
                   COUNT(t.ticket_id) AS resolved,
                   ROUND(AVG(EXTRACT(EPOCH FROM (t.resolved_at - t.created_at))/3600), 1) AS avg_hrs,
                   ROUND(AVG(t.csat_score), 2) AS avg_csat
            FROM agents a
            JOIN ticket_assignments ta ON a.agent_id = ta.agent_id
            JOIN tickets t ON ta.ticket_id = t.ticket_id
            WHERE t.resolved_at IS NOT NULL
            GROUP BY a.agent_id, a.agent_name
            ORDER BY avg_hrs ASC LIMIT 5
        """)
        for r in rows:
            print(f"  {r['agent_name']:<20}  {r['avg_hrs']:>5} hrs avg  "
                  f"CSAT {r['avg_csat']}  ({r['resolved']} resolved)")

        print("\n" + "═" * 60)
        print("  Dashboard complete. Run queries.sql for full detail.")
        print("═" * 60 + "\n")

        cur.close()
        conn.close()

    except psycopg2.OperationalError as e:
        print(f"\n❌  Could not connect: {e}")
        print("    Check DB_CONFIG at the top of this file.\n")

if __name__ == "__main__":
    main()
