-- 데이터베이스 생성
CREATE DATABASE forensicdb;
USE forensicdb;

-- users 테이블
CREATE TABLE users (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    username      VARCHAR(50),
    email         VARCHAR(100),
    password_hash VARCHAR(255)
);

-- orders 테이블
CREATE TABLE orders (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    user_id      INT,
    product_name VARCHAR(100),
    price        INT,
    status       VARCHAR(20),
    timestamp    DATETIME
);

-- payments 테이블
CREATE TABLE payments (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    order_id  INT,
    amount    INT,
    method    VARCHAR(20),
    timestamp DATETIME
);

-- logs 테이블
CREATE TABLE logs (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    user_id   INT,
    action    VARCHAR(255),
    timestamp DATETIME
);
