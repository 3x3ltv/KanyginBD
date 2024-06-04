CREATE OR REPLACE VIEW user_accounts_info AS
SELECT u.id as user_id, u.first_name, u.last_name, a.id, a.balance
FROM operator_telecom.users u
JOIN operator_telecom.accounts a ON u.id = a.user_id;

CREATE INDEX idx_users_name_id ON operator_telecom.users(first_name);
CREATE INDEX idx_accounts_balance_id ON operator_telecom.accounts(balance);

SET enable_seqscan = OFF;
SELECT * FROM operator_telecom.users WHERE first_name = 'Андрей';
SELECT * FROM operator_telecom.accounts WHERE id = 51;
