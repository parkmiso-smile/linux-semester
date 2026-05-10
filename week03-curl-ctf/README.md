# 3주차 — curl 설치하기

## 📌 개요

**curl**을 설치하고, HTTP 헤더 기반 접근 제어를 다루는 웹 CTF 문제를 제작하였다.  
curl을 활용해 브라우저가 보낼 수 없는 맞춤형 요청을 만들어 우회하는 과정으로 웹 해킹의 기본 원리를 체험한다.

## ⚙️ 설치

```bash
sudo apt update
sudo apt install curl
```

---

## 🚩 CTF 문제

### 카테고리
Web

### 시나리오
특정 `User-Agent` 헤더를 가진 클라이언트에게만 FLAG를 반환하는 Flask 서버가 있다.  
브라우저로 접속하면 `Access Denied`가 뜬다. curl로 User-Agent를 변조하여 FLAG를 획득하라.

### 관련 파일
- [server.py](./server.py) — Flask CTF 서버

---

## 📖 문제 제작 과정

**1. 실습 디렉토리 생성**

```bash
mkdir curl_ctf
cd curl_ctf
```

**2. Flask 서버 작성**

```bash
nano server.py
```

→ [server.py](./server.py) 참고

**3. 서버 실행**

```bash
python3 server.py
```

---

## 🔍 문제 풀이

**Step 1. 브라우저로 접속 확인**

```
http://localhost:5000/
```
→ `Access Denied: Your browser is not allowed.`

**Step 2. Chrome 개발자 도구로 User-Agent 변경**

- DevTools → Network 탭 → Network conditions
- "Use browser default" 체크 해제
- Custom User-Agent에 `KingHacker/1.0` 입력 후 새로고침

또는 curl로 직접 요청:

```bash
curl -H "User-Agent: KingHacker/1.0" http://localhost:5000/
```

**🏁 FLAG**
```
FLAG{CURL_UA_BYPASS_SUCCESS}
```
