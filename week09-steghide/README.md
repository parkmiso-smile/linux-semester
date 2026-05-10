# 9주차 — Steghide 설치하기

## 📌 개요

**Steghide**를 설치하고, JPEG 이미지 내부에 비밀번호 기반으로 메시지를 숨기는 스테가노그래피 CTF 문제를 제작하였다.

## ⚙️ 설치

```bash
sudo apt install steghide exiftool
```

---

## 🚩 CTF 문제

### 카테고리
Steganography

### 시나리오
```
경희대학교 프로그래밍 동아리 홍보 포스터에 이상한 점이 있다!
포스터 해상도나 내용은 평범한데, 이미지 파일 크기가 유난히 크다는 신고가 접수되었다.
보안 관리자는 "누군가 포스터 이미지 내부에 비밀 메시지를 숨겼다"고 의심하고 문제 해결을 요청했다.

이미지 내부에서 숨겨진 데이터(FLAG)를 추출하여 공격자가 남긴 메시지를 밝혀내야 한다.
```

### 관련 파일
- `poster.jpg` — 데이터가 숨겨진 이미지 파일 (별도 배포)

---

## 📖 문제 제작 과정

```bash
# 숨길 FLAG 파일 생성
echo "FLAG{STEGHIDE_SECRET_DISCOVERED}" > secret.txt

# 이미지에 파일 삽입 (비밀번호: misomiso1004)
steghide embed -cf poster.jpg -ef secret.txt -p misomiso1004

# 비밀번호 힌트를 이미지 메타데이터에 삽입
exiftool -Comment="password = misomiso1004" poster.jpg
```

---

## 🔍 문제 풀이

**Step 1. 이미지에 숨겨진 데이터 여부 확인**

```bash
steghide info poster.jpg
# → 비밀번호 입력 요구 (아직 모름)
```

**Step 2. 메타데이터 분석으로 비밀번호 획득**

```bash
exiftool poster.jpg
# Comment: password = misomiso1004  ← 발견!
```

**Step 3. 숨겨진 파일 존재 확인**

```bash
steghide info poster.jpg
# Enter passphrase: misomiso1004
# embedded file: "secret.txt" (33 Byte, rijndael-128 cbc, compressed)
```

**Step 4. 파일 추출 및 FLAG 확인**

```bash
steghide extract -sf poster.jpg -p misomiso1004
cat secret.txt
```

**🏁 FLAG**
```
FLAG{STEGHIDE_SECRET_DISCOVERED}
```
