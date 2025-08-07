-- revoke_privileges.sql
-- ❌ Remove all assigned privileges from roles to ensure a clean permission state

-- 📁 Schema: public
SET search_path TO public;

-- 🧼 Revoke from READ-ONLY role
REVOKE ALL PRIVILEGES ON 
    patients,
    appointments,
    doctors,
    treatments
FROM read_only;

-- 🧼 Revoke from READ-WRITE role
REVOKE ALL PRIVILEGES ON 
    appointments,
    treatments,
    billing
FROM read_write;

-- 🧼 Revoke from ADMIN role
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM admin;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM admin;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM admin;

-- 🧼 Revoke USAGE on schema from all roles
REVOKE USAGE ON SCHEMA public FROM read_only, read_write, admin;