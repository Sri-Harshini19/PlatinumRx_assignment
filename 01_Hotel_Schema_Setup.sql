CREATE TABLE users (
    user_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    phone_number VARCHAR,
    mail_id VARCHAR,
    billing_address TEXT
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('USR001', 'John Doe', '9876543210', 'john@example.com', 'Street 1, City A'),
('USR002', 'Alice Smith', '9876543211', 'alice@example.com', 'Street 2, City B'),
('USR003', 'Bob Johnson', '9876543212', 'bob@example.com', 'Street 3, City C');
-----------------------------------------------------------------------
CREATE TABLE bookings (
    booking_id VARCHAR PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no VARCHAR,
    user_id VARCHAR REFERENCES users(user_id)
);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('BK001', '2021-10-10 10:30:00', 'RM101', 'USR001'),
('BK002', '2021-10-15 14:00:00', 'RM102', 'USR002'),
('BK003', '2021-11-05 09:15:00', 'RM103', 'USR001'),
('BK004', '2021-11-20 18:45:00', 'RM104', 'USR003'),
('BK005', '2021-12-01 11:20:00', 'RM105', 'USR002');
--------------------------------------------------------------------------------------------------
CREATE TABLE items (
    item_id VARCHAR PRIMARY KEY,
    item_name VARCHAR,
    item_rate NUMERIC
);

INSERT INTO items (item_id, item_name, item_rate) VALUES
('ITM001', 'Tawa Paratha', 20),
('ITM002', 'Mix Veg', 100),
('ITM003', 'Paneer Curry', 250),
('ITM004', 'Soft Drink', 50);
------------------------------------------------------------------------------------------------------
CREATE TABLE booking_commercials (
    id VARCHAR PRIMARY KEY,
    booking_id VARCHAR REFERENCES bookings(booking_id),
    bill_id VARCHAR,
    bill_date TIMESTAMP,
    item_id VARCHAR REFERENCES items(item_id),
    item_quantity NUMERIC
);

INSERT INTO booking_commercials
(id, booking_id, bill_id, bill_date, item_id, item_quantity)
VALUES
('BC001', 'BK001', 'BILL001', '2021-10-10 12:00:00', 'ITM001', 5),
('BC002', 'BK001', 'BILL001', '2021-10-10 12:00:00', 'ITM003', 4),

('BC003', 'BK002', 'BILL002', '2021-10-15 15:00:00', 'ITM002', 3),
('BC004', 'BK002', 'BILL002', '2021-10-15 15:00:00', 'ITM004', 2),

('BC005', 'BK003', 'BILL003', '2021-11-05 10:00:00', 'ITM003', 2),
('BC006', 'BK003', 'BILL003', '2021-11-05 10:00:00', 'ITM001', 6),

('BC007', 'BK004', 'BILL004', '2021-11-20 19:00:00', 'ITM002', 10),
('BC008', 'BK004', 'BILL004', '2021-11-20 19:00:00', 'ITM004', 5),

('BC009', 'BK005', 'BILL005', '2021-12-01 12:00:00', 'ITM001', 1),
('BC010', 'BK005', 'BILL005', '2021-12-01 12:00:00', 'ITM003', 5);