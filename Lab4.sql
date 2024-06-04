--Generalization
CREATE MATERIALIZED VIEW generalized_users AS
SELECT
    id AS id,
    first_name AS first_name,
    last_name AS last_name,
    anon.generalize_daterange(birth_date, 'decade') AS generalized_birth_decade
FROM
    operator_telecom.users;


--Faking
CREATE MATERIALIZED VIEW faked_user_info AS
SELECT
    id,
    anon.fake_first_name() AS first_name,
    anon.fake_last_name() AS last_name,
    anon.fake_address() AS address
FROM
    operator_telecom.Users;

--Adding noise
CREATE MATERIALIZED VIEW noisy_account_balances AS
SELECT
    id,
    anon.noise(balance, 10) AS noisy_balance
FROM
    operator_telecom.Accounts;


