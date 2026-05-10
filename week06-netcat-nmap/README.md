# 6주차 — Netcat / Nmap 설치하기

## 📌 개요

**Netcat(nc)** 과 **Nmap** 을 설치하고, 포트 스캔을 통해 숨겨진 포트에 접속하여 FLAG를 획득하는 네트워크 CTF 문제를 제작하였다.

## 도구 소개

| 도구 | 설명 |
|------|------|
| Netcat (nc) | TCP/IP를 통해 데이터를 읽고 쓰는 명령줄 유틸리티. 네트워크 디버깅·파일 전송에 사용 |
| Nmap | 네트워크 탐색 및 보안 감사 도구. 호스트·서비스·취약점 검색 |

## ⚙️ 설치

```bash
sudo apt install netcat-openbsd
sudo apt install nmap
```

---

## 🚩 CTF 문제

### 카테고리
Network

### 시나리오
```
Week 5 CTF — Hidden Port Challenge

서버는 어떤 포트 하나에 FLAG를 숨겨두었다.
포트 번호는 공개되지 않았으며, 직접 스캔해야 한다.

해야 할 일
1. 서버에서 열린 포트를 스캔한다.
2. 특정 포트를 찾는다.
3. netcat(nc)으로 포트에 접속한다.
4. FLAG를 획득한다.

힌트: nmap -p- <server_ip>
```

### 관련 파일
- [run_server.sh](./run_server.sh) — FLAG 서버 실행 스크립트

---

## 📖 문제 제작 과정

```bash
mkdir netcat-ctf
cd netcat-ctf
mkdir challenge server
cd server

echo "FLAG{Scan_To_Find_The_Secret_Port}" > flag.txt

# 23456 포트에서 FLAG를 전송하는 일회용 서버 실행
cat flag.txt | nc -lvp 23456
```

이 명령어 동작 순서:
1. nc가 23456 포트에서 외부 연결을 대기
2. 클라이언트가 해당 포트로 접속
3. `flag.txt` 내용이 즉시 전송됨
4. 전송 완료 후 세션 종료

---

## 🔍 문제 풀이

**Step 1. 포트 스캔**

```bash
nmap -p- 127.0.0.1
```

결과 예시:
```
PORT        STATE SERVICE
21/tcp      open  ftp
80/tcp      open  http
23456/tcp   open  aequus   ← 의심스러운 비표준 포트!
```

**Step 2. 해당 포트 접속**

```bash
nc 127.0.0.1 23456
```

**🏁 FLAG**
```
FLAG{Scan_To_Find_The_Secret_Port}
```
