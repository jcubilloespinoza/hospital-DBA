-- grant_privileges.sql
-- 🎯 Assign specific privileges to roles defined in role_setup.sql

-- 📁 Schema: public
-- Ensure all objects are in the correct schema
SET search_path TO public;

-- ✅ READ-ONLY role
-- Can only SELECT from key tables (suitable for doctors)
GRANT SELECT ON 
    patients,
    appointments,
    doctors,
    treatments
TO read_only;

-- ✍️ READ-WRITE role
-- Can SELECT, INSERT, UPDATE (no DELETE for safety)
GRANT SELECT, INSERT, UPDATE ON 
    appointments,
    treatments
TO read_write;

-- 💰 Billing user needs access to billing and treatments
GRANT SELECT, INSERT, UPDATE ON 
    billing
TO read_write;

-- 🔐 ADMIN role
-- Full privileges on all tables and sequences
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO admin;
