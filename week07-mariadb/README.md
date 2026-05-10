# 7주차 — MariaDB 설치하기

## 📌 개요

**MariaDB**를 설치하고, 쇼핑몰 데이터베이스에서 결제 금액 조작 흔적을 분석하는 포렌식 CTF 문제를 제작하였다.  
MySQL과 거의 동일하지만 100% 오픈소스인 MariaDB를 사용하였다.

## ⚙️ 설치

```bash
sudo apt install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation   # 초기 보안 설정
sudo mysql -u root -p
```

---

## 🚩 CTF 문제

### 카테고리
Forensics / Database

### 시나리오
```
CTF 시나리오: 쇼핑몰 주문 조작 사건

2024년 10월 3일, 쇼핑몰의 내부 데이터베이스에서 수상한 주문 결제 기록이 발견되었다.
한 사용자가 고가의 물건을 주문했음에도 해당 주문의 결제 금액이 0원으로 기록되어 있었다.
관리 로그(logs 테이블)를 확인한 결과, 일부 로그가 삭제된 듯한 흔적도 발견되었다.

주문을 조작한 사람의 이름을 알아내라.
```

### 관련 파일
- [setup_db.sql](./setup_db.sql) — 데이터베이스 및 테이블 생성 SQL
- [insert_data.sql](./insert_data.sql) — 데이터 삽입 SQL

---

## 📖 문제 제작 과정

→ [setup_db.sql](./setup_db.sql), [insert_data.sql](./insert_data.sql) 참고

데이터베이스 파일 추출:
```bash
sudo mysqldump forensicdb > shopping_fraud.sql
```

---

## 🔍 문제 풀이

**도구**: [DBeaver](https://dbeaver.io/download/) 또는 mysql 클라이언트

**Step 1. logs 테이블에서 수상한 로그 확인**

```sql
SELECT * FROM logs;
```

→ `SYSTEM_ALERT: Incomplete log chain detected for user_id=4` 발견  
→ `user_id=4` 의 행동이 의심스럽다.

**Step 2. orders 테이블 확인**

```sql
SELECT * FROM orders WHERE user_id = 4;
```

→ Gaming Chair 300,000원 주문이 `paid` 상태로 등록되어 있음.

**Step 3. payments 테이블 확인**

```sql
SELECT * FROM payments WHERE order_id = 4;
```

→ `amount = 0`, `method = NULL` → 결제 금액이 0원으로 조작됨!

**Step 4. users 테이블에서 범인 확인**

```sql
SELECT * FROM users WHERE id = 4;
```

→ `username = attacker`, `email = hack@hackmail.com`

**🏁 FLAG (범인 이름)**
```
attacker
```
