-- role_setup.sql
-- 🔐 Create roles for different types of users in the Hospital DBA project

-- 1️⃣ Create base roles (no login)
CREATE ROLE read_only;
CREATE ROLE read_write;
CREATE ROLE admin;

-- 2️⃣ Create login roles (actual users) and assign them base roles

-- 👨‍⚕️ Doctor user (can read patient info & appointments, but not modify)
CREATE ROLE doctor_user LOGIN PASSWORD 'DoctorSecurePass123!';
GRANT read_only TO doctor_user;

-- 💊 Nurse user (can read and write appointments & treatments, but not billing)
CREATE ROLE nurse_user LOGIN PASSWORD 'NurseSecurePass123!';
GRANT read_write TO nurse_user;

-- 📋 Billing staff (can read/write billing info only)
CREATE ROLE billing_user LOGIN PASSWORD 'BillingSecurePass123!';
GRANT read_write TO billing_user;

-- 🧑‍💻 Admin user (full access)
CREATE ROLE hospital_admin LOGIN PASSWORD 'AdminSecurePass123!';
GRANT admin TO hospital_admin;