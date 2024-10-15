-- Connect to PostgreSQL and create the insurance database
CREATE DATABASE insurance;

-- Connect to the insurance database
\c insurance;

-- Create 'clients' table
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Create 'agents' table
CREATE TABLE agents (
    agent_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Create 'policies' table
CREATE TABLE policies (
    policy_id SERIAL PRIMARY KEY,
    client_id INT,
    agent_id INT,
    policy_type VARCHAR(50),
    start_date DATE,
    premium DECIMAL(10,2),
    end_date DATE,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- Create 'claims' table
CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,
    policy_id INT,
    claim_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- Create 'payments' table
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    policy_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_type VARCHAR(20),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

);

-- Insert data into 'agents' table
INSERT INTO agents (first_name, last_name, phone, email) VALUES
('Alice', 'Johnson', '555-4321', 'alice.j@email.com'),
('Bob', 'Lee', '555-8765', 'bob.lee@email.com'),
('Carol', 'White', '555-1357', 'carol.w@email.com'),
('David', 'Miller', '555-2468', 'david.m@email.com'),
('Eva', 'Parker', '555-9753', 'eva.p@email.com');

-- Insert data into 'clients' table
INSERT INTO clients (first_name, last_name, address, phone, email) VALUES
('John', 'Doe', '123 Main St', '555-1234', 'john.doe@email.com'),
('Jane', 'Smith', '456 Oak Ave', '555-5678', 'jane.smith@email.com'),
('Robert', 'Brown', '789 Pine Rd', '555-9876', 'robert.brown@email.com'),
('Emily', 'Clark', '22 Birch St', '555-3333', 'emily.clark@email.com'),
('Michael', 'Davis', '94 Maple Blvd', '555-4444', 'michael.davis@email.com'),
('Sarah', 'Wilson', '73 Cedar Ln', '555-5555', 'sarah.wilson@email.com'),
('James', 'Johnson', '101 Elm St', '555-6666', 'james.johnson@email.com'),
('Patricia', 'Taylor', '15 Ash Rd', '555-7777', 'patricia.taylor@email.com'),
('Chris', 'Anderson', '200 Walnut Cir', '555-8888', 'chris.anderson@email.com'),
('Linda', 'Thomas', '76 Spruce St', '555-9999', 'linda.thomas@email.com'),
('Daniel', 'Jackson', '35 Fir St', '555-1111', 'daniel.jackson@email.com'),
('Sophia', 'Martinez', '67 Hickory Ct', '555-2222', 'sophia.martinez@email.com'),
('Ethan', 'Lopez', '89 Cherry Ln', '555-3334', 'ethan.lopez@email.com'),
('Grace', 'Harris', '102 Palm Dr', '555-2345', 'grace.harris@email.com'),
('Jacob', 'Young', '305 Magnolia Ave', '555-3456', 'jacob.young@email.com'),
('Olivia', 'Lee', '12 Cypress Pl', '555-4567', 'olivia.lee@email.com'),
('Noah', 'Walker', '93 Redwood Dr', '555-5678', 'noah.walker@email.com'),
('Ava', 'Allen', '200 Willow Ln', '555-6789', 'ava.allen@email.com'),
('Liam', 'Scott', '52 Hemlock St', '555-7890', 'liam.scott@email.com'),
('Isabella', 'King', '44 Sycamore St', '555-8901', 'isabella.king@email.com'),
('David', 'Garcia', '22 Pine St', '555-1122', 'david.garcia@email.com'),
('Sophia', 'Wright', '31 Elm St', '555-1233', 'sophia.wright@email.com'),
('Alexander', 'Clark', '45 Maple St', '555-1344', 'alex.clark@email.com'),
('Ella', 'Walker', '78 Oak Dr', '555-1455', 'ella.walker@email.com'),
('Charlotte', 'Nelson', '91 Birch St', '555-1566', 'charlotte.nelson@email.com'),
('Lucas', 'Robinson', '36 Spruce St', '555-1677', 'lucas.robinson@email.com'),
('Mia', 'Rivera', '19 Walnut Cir', '555-1788', 'mia.rivera@email.com'),
('Benjamin', 'Baker', '89 Palm St', '555-1899', 'ben.baker@email.com'),
('Emma', 'Perez', '12 Willow Ave', '555-1900', 'emma.perez@email.com'),
('William', 'Hughes', '52 Cypress Dr', '555-2000', 'will.hughes@email.com');

-- Insert data into 'policies' table
INSERT INTO policies (client_id, agent_id, policy_type, start_date, premium, end_date) VALUES
(1, 1, 'Auto', '2023-01-01', 500, '2024-01-01'),
(2, 2, 'Home', '2022-06-15', 1000, '2025-06-15'),
(3, 3, 'Health', '2023-04-10', 300, '2024-04-10'),
(4, 4, 'Auto', '2023-03-05', 550, '2024-03-05'),
(5, 5, 'Life', '2022-09-12', 700, '2025-09-12'),
(6, 1, 'Home', '2022-11-20', 1200, '2026-11-20'),
(7, 2, 'Health', '2023-02-17', 400, '2024-02-17'),
(8, 3, 'Auto', '2023-05-30', 450, '2024-05-30'),
(9, 4, 'Home', '2023-06-22', 1500, '2026-06-22'),
(10, 5, 'Life', '2022-10-01', 850, '2025-10-01'),
(11, 1, 'Health', '2023-07-18', 350, '2024-07-18'),
(12, 2, 'Auto', '2022-08-05', 600, '2023-08-05');

-- Insert data into 'claims' table
INSERT INTO claims (policy_id, claim_date, amount, status) VALUES
(1, '2023-05-01', 2000, 'Approved'),
(2, '2023-07-22', 5000, 'Pending'),
(3, '2023-09-10', 1500, 'Denied'),
(4, '2023-10-01', 3000, 'Approved'),
(5, '2023-02-11', 4500, 'Pending'),
(6, '2023-04-05', 1800, 'Denied'),
(7, '2023-06-15', 500, 'Approved'),
(8, '2023-08-20', 2200, 'Pending');

-- Insert data into 'payments' table
INSERT INTO payments (policy_id, payment_date, amount, payment_type) VALUES
(1, '2023-02-01', 500, 'Annual'),
(2, '2022-06-15', 1000, 'Annual'),
(3, '2023-04-10', 300, 'Monthly'),
(4, '2023-03-05', 550, 'Annual'),
(5, '2022-09-12', 700, 'Annual'),
(6, '2022-11-20', 1200, 'Annual'),
(7, '2023-02-17', 400, 'Annual'),
(8, '2023-05-30', 450, 'Annual');

