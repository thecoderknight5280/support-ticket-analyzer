-- ============================================================
-- Support Ticket Analyzer — seed_data.sql
-- 50 realistic mock support tickets across 5 products
-- ============================================================

-- AGENTS
INSERT INTO agents (agent_name, region, team) VALUES
('Vamsy Reddy',    'Asia Pacific', 'Enterprise Support'),
('Priya Sharma',   'Asia Pacific', 'Enterprise Support'),
('Amit Kulkarni',  'Asia Pacific', 'SMB Support'),
('Sneha Nair',     'EMEA',         'Enterprise Support'),
('Kiran Menon',    'EMEA',         'SMB Support'),
('Ravi Teja',      'Americas',     'Enterprise Support'),
('Divya Pillai',   'Americas',     'SMB Support'),
('Suresh Babu',    'Asia Pacific', 'Escalations');

-- TICKETS (50 rows — 5 products, mixed priority/status/CSAT)
INSERT INTO tickets (customer_name, product, priority, status, created_at, resolved_at, csat_score) VALUES
('Accenture',        'VPOM',      'P1', 'resolved',    '2026-01-03 09:00', '2026-01-03 14:30', 5),
('TCS',              'Vista Plus','P2', 'resolved',    '2026-01-05 10:15', '2026-01-06 11:00', 4),
('Infosys',          'TeamSite',  'P1', 'resolved',    '2026-01-07 08:30', '2026-01-07 16:45', 5),
('Wipro',            'VPOM',      'P3', 'closed',      '2026-01-08 13:00', '2026-01-10 09:00', 3),
('HCL',              'Vista Plus','P2', 'resolved',    '2026-01-09 11:00', '2026-01-09 17:00', 4),
('Tech Mahindra',    'TeamSite',  'P3', 'closed',      '2026-01-10 14:00', '2026-01-13 10:00', 4),
('Cognizant',        'VPOM',      'P1', 'resolved',    '2026-01-12 09:30', '2026-01-12 13:00', 5),
('Mphasis',          'Vista Plus','P4', 'closed',      '2026-01-13 10:00', '2026-01-15 14:00', 2),
('L&T Infotech',     'TeamSite',  'P2', 'resolved',    '2026-01-14 11:30', '2026-01-15 09:00', 4),
('Hexaware',         'VPOM',      'P3', 'resolved',    '2026-01-15 15:00', '2026-01-16 11:00', 3),
('Mindtree',         'Vista Plus','P1', 'resolved',    '2026-01-17 08:00', '2026-01-17 12:30', 5),
('NIIT Tech',        'TeamSite',  'P2', 'closed',      '2026-01-18 13:00', '2026-01-20 10:00', 4),
('Zensar',           'VPOM',      'P4', 'resolved',    '2026-01-19 10:00', '2026-01-21 14:00', 3),
('Persistent',       'Vista Plus','P1', 'resolved',    '2026-01-20 09:15', '2026-01-20 15:00', 5),
('Cyient',           'TeamSite',  'P3', 'closed',      '2026-01-22 14:00', '2026-01-24 09:00', 4),
('Sasken',           'VPOM',      'P2', 'resolved',    '2026-01-23 10:30', '2026-01-24 11:00', 4),
('Sonata Software',  'Vista Plus','P4', 'closed',      '2026-01-25 11:00', '2026-01-28 15:00', 2),
('Infoedge',         'TeamSite',  'P1', 'resolved',    '2026-01-27 09:00', '2026-01-27 14:00', 5),
('Mastech',          'VPOM',      'P2', 'resolved',    '2026-01-28 13:00', '2026-01-29 10:00', 3),
('Tata Elxsi',       'Vista Plus','P3', 'closed',      '2026-01-29 10:00', '2026-01-31 12:00', 4),
('Accenture',        'TeamSite',  'P1', 'resolved',    '2026-02-02 08:30', '2026-02-02 13:30', 5),
('TCS',              'VPOM',      'P2', 'resolved',    '2026-02-04 10:00', '2026-02-05 09:00', 4),
('Infosys',          'Vista Plus','P3', 'closed',      '2026-02-06 14:00', '2026-02-08 11:00', 3),
('Wipro',            'TeamSite',  'P4', 'resolved',    '2026-02-07 11:30', '2026-02-10 14:00', 2),
('HCL',              'VPOM',      'P1', 'resolved',    '2026-02-09 09:00', '2026-02-09 16:00', 5),
('Cognizant',        'Vista Plus','P2', 'in_progress', '2026-02-11 10:00', NULL,               NULL),
('Mphasis',          'TeamSite',  'P1', 'in_progress', '2026-02-13 08:30', NULL,               NULL),
('L&T Infotech',     'VPOM',      'P3', 'open',        '2026-02-14 13:00', NULL,               NULL),
('Hexaware',         'Vista Plus','P2', 'resolved',    '2026-02-15 09:30', '2026-02-16 11:00', 4),
('Mindtree',         'TeamSite',  'P4', 'closed',      '2026-02-17 11:00', '2026-02-20 10:00', 3),
('NIIT Tech',        'VPOM',      'P1', 'resolved',    '2026-02-18 09:00', '2026-02-18 14:00', 5),
('Zensar',           'Vista Plus','P2', 'open',        '2026-02-20 10:30', NULL,               NULL),
('Persistent',       'TeamSite',  'P3', 'resolved',    '2026-02-21 14:00', '2026-02-23 09:00', 4),
('Cyient',           'VPOM',      'P1', 'in_progress', '2026-02-22 08:00', NULL,               NULL),
('Sasken',           'Vista Plus','P4', 'closed',      '2026-02-24 11:00', '2026-02-27 15:00', 2),
('Sonata Software',  'TeamSite',  'P2', 'resolved',    '2026-02-25 10:00', '2026-02-26 10:00', 4),
('Infoedge',         'VPOM',      'P3', 'open',        '2026-02-26 14:00', NULL,               NULL),
('Mastech',          'Vista Plus','P1', 'resolved',    '2026-02-28 09:00', '2026-02-28 16:00', 5),
('Tata Elxsi',       'TeamSite',  'P2', 'resolved',    '2026-03-01 10:30', '2026-03-02 11:00', 4),
('Accenture',        'VPOM',      'P4', 'closed',      '2026-03-03 11:00', '2026-03-06 14:00', 3),
('TCS',              'Vista Plus','P1', 'resolved',    '2026-03-05 09:00', '2026-03-05 14:30', 5),
('Infosys',          'TeamSite',  'P2', 'resolved',    '2026-03-07 10:00', '2026-03-08 09:00', 4),
('Wipro',            'VPOM',      'P3', 'open',        '2026-03-10 13:00', NULL,               NULL),
('HCL',              'Vista Plus','P1', 'in_progress', '2026-03-12 08:30', NULL,               NULL),
('Tech Mahindra',    'TeamSite',  'P2', 'resolved',    '2026-03-14 11:00', '2026-03-15 10:00', 4),
('Cognizant',        'VPOM',      'P4', 'closed',      '2026-03-16 14:00', '2026-03-19 12:00', 3),
('Mphasis',          'Vista Plus','P1', 'resolved',    '2026-03-18 09:00', '2026-03-18 15:00', 5),
('L&T Infotech',     'TeamSite',  'P3', 'open',        '2026-03-20 10:00', NULL,               NULL),
('Hexaware',         'VPOM',      'P2', 'resolved',    '2026-03-22 11:30', '2026-03-23 10:00', 4),
('Mindtree',         'Vista Plus','P4', 'open',        '2026-03-25 13:00', NULL,               NULL);

-- TICKET ASSIGNMENTS (assign each ticket to an agent)
INSERT INTO ticket_assignments (ticket_id, agent_id, assigned_at)
SELECT t.ticket_id,
       ((t.ticket_id % 8) + 1) AS agent_id,
       t.created_at + INTERVAL '15 minutes'
FROM tickets t;
