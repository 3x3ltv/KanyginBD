CREATE SCHEMA operator_telecom;

CREATE TABLE operator_telecom .Users  (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15) UNIQUE,
    address VARCHAR(100)
);

ALTER TABLE operator_telecom.Users
ADD COLUMN birth_date DATE;

UPDATE operator_telecom.Users
SET birth_date = DATE '1970-01-01' + (floor(random() * 365 * 40) * interval '1 day')
WHERE birth_date IS NOT NULL;


CREATE TABLE operator_telecom .TariffPlans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    cost DECIMAL(10,2),
    conditions TEXT
);

CREATE TABLE operator_telecom.Accounts (
    id SERIAL PRIMARY KEY,
    user_id INT,
    plan_id INT,
    balance DECIMAL(10,2),
    creation_date DATE,
    FOREIGN KEY (user_id) REFERENCES operator_telecom .Users(id),
    FOREIGN KEY (plan_id) REFERENCES operator_telecom .TariffPlans(id)
);

CREATE TABLE operator_telecom .Calls (
    call_id SERIAL PRIMARY KEY,
    caller_id INT,
    receiver_id INT,
    date_time TIMESTAMP,
    duration INT,
    type VARCHAR(20),
    FOREIGN KEY (caller_id) REFERENCES operator_telecom .Users(id),
    FOREIGN KEY (receiver_id) REFERENCES operator_telecom .Users(id)
);

CREATE TABLE operator_telecom .Messages (
    message_id SERIAL PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    date_time TIMESTAMP,
    text TEXT,
    type VARCHAR(20),
    FOREIGN KEY (sender_id) REFERENCES operator_telecom .Users(id),
    FOREIGN KEY (receiver_id) REFERENCES operator_telecom .Users(id)
);

CREATE TABLE operator_telecom .InternetTraffic (
    id SERIAL PRIMARY KEY,
    user_id INT,
    volume INT,
    date DATE,
    traffic_type VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES operator_telecom .Users(id)
);

CREATE TABLE operator_telecom .services (
    id SERIAL PRIMARY KEY,
    description TEXT
);

CREATE TABLE  operator_telecom.account_services (
    account_service_id SERIAL PRIMARY KEY,
    account_id INT,
    service_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (account_id) REFERENCES operator_telecom .accounts(id),
    FOREIGN KEY (service_id) REFERENCES operator_telecom .services(id)
);

INSERT INTO operator_telecom.users (first_name, last_name, phone_number, address)
VALUES
  ('Иван', 'Иванов', '123456789', 'Москва'),
  ('Петр', 'Петров', '987654321', 'Санкт-Петербург'),
  ('Анна', 'Сидорова', '456789123', 'Новосибирск'),
  ('Мария', 'Павлова', '789123456', 'Екатеринбург'),
  ('Алексей', 'Смирнов', '321654987', 'Казань'),
  ('Елена', 'Михайлова', '654987321', 'Челябинск'),
  ('Дмитрий', 'Васильев', '159357486', 'Самара'),
  ('Ольга', 'Петрова', '456123789', 'Омск'),
  ('Ирина', 'Козлова', '852741963', 'Уфа'),
  ('Владимир', 'Новиков', '369852147', 'Красноярск'),
  ('Андрей', 'Морозов', '147258369', 'Пермь'),
  ('Наталья', 'Алексеева', '258369147', 'Воронеж'),
  ('Сергей', 'Федоров', '963852741', 'Волгоград'),
  ('Татьяна', 'Ковалева', '741852963', 'Ростов-на-Дону'),
  ('Антон', 'Соколов', '852963741', 'Краснодар');

\COPY operator_telecom.accounts(user_id, plan_id, balance, creation_date) FROM 'C:/Users/Максим/DataGripProjects/OperatorLab/accounts.csv' DELIMITER ',' CSV HEADER;

INSERT INTO operator_telecom.accounts (user_id, plan_id, balance, creation_date)
VALUES
(1, 1, 100.00, '2024-03-01'),
(2, 2, 50.00, '2024-03-01'),
(3, 1, 200.00, '2024-03-02'),
(4, 3, 75.00, '2024-03-02'),
(5, 2, 150.00, '2024-03-03'),
(6, 1, 300.00, '2024-03-03'),
(7, 3, 25.00, '2024-03-04'),
(8, 1, 350.00, '2024-03-04'),
(9, 2, 100.00, '2024-03-05'),
(10, 3, 125.00, '2024-03-05'),
(11, 1, 250.00, '2024-03-06'),
(12, 2, 200.00, '2024-03-06'),
(13, 3, 50.00, '2024-03-07'),
(14, 1, 400.00, '2024-03-07'),
(15, 2, 75.00, '2024-03-08');

INSERT INTO operator_telecom.tariffplans (id, name, description, cost, conditions)
VALUES
    (1, 'План 1', 'Описание плана 1', 10.00, 'Условия плана 1'),
    (2, 'План 2', 'Описание плана 2', 15.00, 'Условия плана 2'),
    (3, 'План 3', 'Описание плана 3', 20.00, 'Условия плана 3'),
    (4, 'План 4', 'Описание плана 4', 25.00, 'Условия плана 4'),
    (5, 'План 5', 'Описание плана 5', 30.00, 'Условия плана 5'),
    (6, 'План 6', 'Описание плана 6', 35.00, 'Условия плана 6'),
    (7, 'План 7', 'Описание плана 7', 40.00, 'Условия плана 7'),
    (8, 'План 8', 'Описание плана 8', 45.00, 'Условия плана 8'),
    (9, 'План 9', 'Описание плана 9', 50.00, 'Условия плана 9'),
    (10, 'План 10', 'Описание плана 10', 55.00, 'Условия плана 10'),
    (11, 'План 11', 'Описание плана 11', 60.00, 'Условия плана 11'),
    (12, 'План 12', 'Описание плана 12', 65.00, 'Условия плана 12'),
    (13, 'План 13', 'Описание плана 13', 70.00, 'Условия плана 13'),
    (14, 'План 14', 'Описание плана 14', 75.00, 'Условия плана 14'),
    (15, 'План 15', 'Описание плана 15', 80.00, 'Условия плана 15');


SELECT *  FROM operator_telecom.accounts