# 8주차 — Bind9 설치하기

## 📌 개요

**BIND9(DNS 서버)** 를 설치하고, DNS zone 파일 변조를 통한 DNS 하이재킹 공격을 시뮬레이션하는 CTF 문제를 제작하였다.

## ⚙️ 설치

```bash
sudo apt install bind9 bind9-utils -y
```

### 주요 파일

| 파일/폴더 | 역할 |
|-----------|------|
| `/etc/bind/named.conf` | 메인 설정 파일 |
| `/etc/bind/named.conf.options` | DNS 옵션 설정 |
| `/etc/bind/named.conf.local` | 사용자 zone 설정 |
| `/etc/bind/zones/` | zone 파일 저장 폴더 |

---

## 🚩 CTF 문제

### 카테고리
Network / DNS

### 시나리오
```
경희대학교 동아리 연합 홈페이지 club-khu.kr에서 학생들이 접속하면
정상 사이트가 뜨지 않고 수상한 피싱 페이지로 이동하는 현상이 발생했다.
웹 서버에는 문제 없었지만, DNS 서버(BIND9)의 zone 파일에서 누군가 고의로 레코드를 변경한 흔적이 발견되었다.
이것을 분석해서 FLAG를 획득하여라.
```

### 관련 파일
- [db.club-khu.kr](./db.club-khu.kr) — 변조된 DNS zone 파일

---

## 📖 문제 제작 과정

```bash
sudo mkdir /etc/bind/zones
sudo nano /etc/bind/zones/db.club-khu.kr
```

→ [db.club-khu.kr](./db.club-khu.kr) 참고

```bash
# zone 파일을 named.conf.local에 등록
sudo nano /etc/bind/named.conf.local
```

```
zone "club-khu.kr" {
    type master;
    file "/etc/bind/zones/db.club-khu.kr";
};
```

```bash
sudo chown -R bind:bind /etc/bind/zones

# DNS를 로컬 Bind9로 변경
sudo nano /etc/resolv.conf
# nameserver 127.0.0.1

# FLAG 웹서버 실행
echo "FLAG{DNS_HIJACKING_SUCCESS}" > index.html
sudo python3 -m http.server 80
```

---

## 🔍 문제 풀이

**Step 1. zone 파일 확인**

```bash
cat /etc/bind/named.conf.local
# club-khu.kr zone 파일 경로 확인

cat /etc/bind/zones/db.club-khu.kr
```

| 레코드 | 유형 | 데이터 | 분석 |
|--------|------|--------|------|
| www | IN A | 203.0.113.10 | 정상 레코드 |
| @ | IN A | 127.0.0.2 | **조작된 레코드** → 피싱 페이지로 리다이렉션 |
| secret | IN A | 127.0.0.1 | **숨겨진 레코드** → FLAG 서버 위치 |

**Step 2. 피싱 페이지 확인**

```
http://club-khu.kr → "Hacked by ??? System Breached."
```

**Step 3. FLAG 획득**

```
http://secret.club-khu.kr → FLAG{DNS_HIJACKING_SUCCESS}
```

**🏁 FLAG**
```
FLAG{DNS_HIJACKING_SUCCESS}
```
