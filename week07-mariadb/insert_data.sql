USE forensicdb;

-- 정상 유저 데이터
INSERT INTO users (username, email, password_hash) VALUES
('alice',    'alice@example.com',   'xxx'),
('bob',      'bob@example.com',     'xxx'),
('charlie',  'charlie@example.com', 'xxx'),
('attacker', 'hack@hackmail.com',   'xxx');

-- 정상 주문 데이터
INSERT INTO orders (user_id, product_name, price, status, timestamp) VALUES
(1, 'Keyboard',     45000,  'paid', '2024-10-01 10:10:00'),
(2, 'Mouse',        25000,  'paid', '2024-10-01 11:00:00'),
(3, 'Monitor',      200000, 'paid', '2024-10-02 09:00:00');

-- 공격자 주문 (고가 상품)
INSERT INTO orders (user_id, product_name, price, status, timestamp) VALUES
(4, 'Gaming Chair', 300000, 'paid', '2024-10-03 01:00:00');

-- 정상 결제 데이터
INSERT INTO payments (order_id, amount, method, timestamp) VALUES
(1, 45000,  'card', '2024-10-01 10:11:00'),
(2, 25000,  'card', '2024-10-01 11:01:00'),
(3, 200000, 'bank', '2024-10-02 09:01:00');

-- 공격자 결제 조작 (amount=0)
INSERT INTO payments (order_id, amount, method, timestamp) VALUES
(4, 0, NULL, '2024-10-03 01:00:01');

-- 정상 로그
INSERT INTO logs (user_id, action, timestamp) VALUES
(1, 'ORDER_CREATE:1', '2024-10-01 10:10:01'),
(2, 'ORDER_CREATE:2', '2024-10-01 11:00:01'),
(3, 'ORDER_CREATE:3', '2024-10-02 09:00:01');

-- 공격자 로그 + 시스템 경고 (힌트)
INSERT INTO logs (user_id, action, timestamp) VALUES
(4, 'ORDER_CREATE:4', '2024-10-03 01:00:01'),
(0, 'SYSTEM_ALERT: Incomplete log chain detected for user_id=4', '2024-10-03 01:00:02');
