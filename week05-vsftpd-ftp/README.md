# 5주차 — vsftpd 설치하기

## 📌 개요

**vsftpd(Very Secure FTP Daemon)** 를 설치하고, FTP 서버에서 숨겨진 파일(`.`으로 시작하는 파일)을 찾아내는 CTF 문제를 제작하였다.

## 핵심 보안 개념

| 기능 | 설명 |
|------|------|
| 사용자 격리 | FTP 로그인 시 홈 디렉토리를 루트처럼 강제 설정, 타 영역 접근 불가 |
| 최소 권한 원칙 | 중요 작업 외 최소 권한만 사용, 피해 최소화 |

## ⚙️ 설치

```bash
sudo apt install vsftpd
```

---

## 🚩 CTF 문제

### 카테고리
Forensics

### 시나리오
```
당신은 보안 연구원으로서, 외부 공격자에 의해 유출된 것으로 보이는 로그 파일을 분석하고 있다.

로그 흔적 분석:
Mon Nov 24 20:11:22 2025 [pid 2] [ftpuser] OK UPLOAD: "/home/ftpuser/.secret_flag"

이 로그는 ftpuser라는 계정이 .secret_flag라는 숨겨진 파일을 서버에 업로드했다는 기록이다.
FTP 서비스가 활성화되어 있고, ftpuser의 계정 정보를 이미 알고 있다는 가정 하에,
FTP 클라이언트를 사용하여 서버에 접속하고 이 숨겨진 파일을 찾아 다운로드하라.
```

### 관련 파일
- [setup.sh](./setup.sh) — 문제 환경 구성 스크립트

---

## 📖 문제 제작 과정

```bash
sudo apt install vsftpd

# FTP 전용 계정 생성
sudo adduser ftpuser

# 숨겨진 FLAG 파일 생성
echo "FLAG{find_hidden_file}" | sudo tee /home/ftpuser/.secret_flag
sudo chown ftpuser:ftpuser /home/ftpuser/.secret_flag

# 위장용 일반 파일 생성
sudo mkdir /home/ftpuser/files
sudo chown ftpuser:ftpuser /home/ftpuser/files
echo "일반 문서입니다" | sudo tee /home/ftpuser/files/readme.txt
sudo chown ftpuser:ftpuser /home/ftpuser/files/readme.txt
```

리눅스에서 파일명이 `.`(점)으로 시작하면 숨김 파일이 되어 일반 `ls`로는 보이지 않는다.

---

## 🔍 문제 풀이

**Step 1. FTP 접속**

```bash
ftp 127.0.0.1
# Name: ftpuser
# Password: (설정한 비밀번호)
```

**Step 2. 일반 목록 확인 → 숨김 파일 보이지 않음**

```bash
ftp> ls
# .secret_flag 가 보이지 않음
```

**Step 3. 숨김 파일 포함 목록 확인**

```bash
ftp> ls -a
# .secret_flag 발견!
```

**Step 4. 파일 다운로드 및 확인**

```bash
ftp> get .secret_flag
ftp> exit
cat .secret_flag
```

**🏁 FLAG**
```
FLAG{find_hidden_file}
```
