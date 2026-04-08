CREATE TABLE clinics (
    cid VARCHAR PRIMARY KEY,
    clinic_name VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR
);
INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('CL001', 'HealthCare Plus', 'Hyderabad', 'Telangana', 'India'),
('CL002', 'MediCare Center', 'Hyderabad', 'Telangana', 'India'),
('CL003', 'City Clinic', 'Bangalore', 'Karnataka', 'India'),
('CL004', 'Wellness Hub', 'Bangalore', 'Karnataka', 'India');
-------------------------------------------------------------------------------------------------
CREATE TABLE customer (
    uid VARCHAR PRIMARY KEY,
    name VARCHAR,
    mobile VARCHAR
);
INSERT INTO customer (uid, name, mobile) VALUES
('CUS001', 'John Doe', '9876543210'),
('CUS002', 'Alice Smith', '9876543211'),
('CUS003', 'Bob Johnson', '9876543212'),
('CUS004', 'David Lee', '9876543213');
------------------------------------------------------------------------------------------------------
CREATE TABLE clinic_sales (
    oid VARCHAR PRIMARY KEY,
    uid VARCHAR REFERENCES customer(uid),
    cid VARCHAR REFERENCES clinics(cid),
    amount NUMERIC,
    datetime TIMESTAMP,
    sales_channel VARCHAR
);
INSERT INTO clinic_sales
(oid, uid, cid, amount, datetime, sales_channel)
VALUES
('ORD001', 'CUS001', 'CL001', 5000, '2021-01-10 10:00:00', 'Online'),
('ORD002', 'CUS002', 'CL001', 8000, '2021-01-15 11:00:00', 'Offline'),
('ORD003', 'CUS003', 'CL002', 12000, '2021-02-12 12:00:00', 'Referral'),
('ORD004', 'CUS001', 'CL003', 7000, '2021-02-20 14:00:00', 'Online'),
('ORD005', 'CUS004', 'CL004', 15000, '2021-03-05 09:00:00', 'Offline'),
('ORD006', 'CUS002', 'CL002', 6000, '2021-03-15 13:00:00', 'Referral'),
('ORD007', 'CUS003', 'CL003', 20000, '2021-04-18 16:00:00', 'Online'),
('ORD008', 'CUS004', 'CL004', 9000, '2021-04-25 17:00:00', 'Offline');
------------------------------------------------------------------------------------------------
CREATE TABLE expenses (
    eid VARCHAR PRIMARY KEY,
    cid VARCHAR REFERENCES clinics(cid),
    description TEXT,
    amount NUMERIC,
    datetime TIMESTAMP
);
INSERT INTO expenses
(eid, cid, description, amount, datetime)
VALUES
('EXP001', 'CL001', 'Medical Supplies', 3000, '2021-01-12 08:00:00'),
('EXP002', 'CL002', 'Rent', 5000, '2021-02-10 09:00:00'),
('EXP003', 'CL003', 'Electricity', 4000, '2021-02-15 10:00:00'),
('EXP004', 'CL004', 'Maintenance', 6000, '2021-03-18 11:00:00'),
('EXP005', 'CL001', 'Staff Salary', 7000, '2021-04-05 12:00:00'),
('EXP006', 'CL002', 'Equipment', 8000, '2021-04-20 13:00:00');