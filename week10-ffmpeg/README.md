# 10주차 — FFmpeg 설치하기

## 📌 개요

**FFmpeg**와 **espeak(TTS)** 를 설치하고, 음성 파일을 AES-256으로 암호화한 뒤 역재생하여 숨긴 CTF 문제를 제작하였다.

## ⚙️ 설치

```bash
sudo apt install ffmpeg -y
sudo apt install espeak -y
```

---

## 🚩 CTF 문제

### 카테고리
Crypto / Audio Forensics

### 시나리오
```
학교 방송반 서버에 저장된 안내 방송 음성이 공격자에 의해 AES-256으로 암호화된 뒤
거꾸로(reverse) 저장된 상태로 유출되었다.

관리자 조사 결과, 공격자는 암호화 비밀번호를 "방송반 회장 이름 + 생년월일" 조합으로
만든다는 것이 로그에서 확인된다.

이 안내 음성을 복원하여 FLAG를 획득해보시오.
```

힌트: 문제와 함께 제공된 방송반 홍보 포스터 이미지를 분석하라.  
<img width="314" height="447" alt="image" src="https://github.com/user-attachments/assets/da384c97-61a2-4077-be99-6d4e537f99b5" />

→ 동아리 회장 이름: 박미소 → `parkmiso`  
→ 이메일 `miso0422@...` → 생년월일 `0422`  
→ **비밀번호: `parkmiso0422`**

### 관련 파일
- `challenge.wav` — AES-256 암호화 + 역재생된 문제 파일 (별도 배포)
- [make_challenge.sh](./make_challenge.sh) — 문제 파일 생성 스크립트

---

## 📖 문제 제작 과정

```bash
# FLAG 포함 음성 파일 생성 (TTS)
espeak "This is the encrypted broadcast. The flag is ADVANCED_REVERSE_AUDIO." \
    -w original.wav

# WAV → RAW PCM 변환 (헤더 제거)
ffmpeg -i original.wav -f s16le -acodec pcm_s16le raw.pcm

# AES-256 암호화
openssl enc -aes-256-cbc -salt -in raw.pcm -out encrypted.pcm -k parkmiso0422

# PCM → WAV 래핑
ffmpeg -f s16le -ar 44100 -ac 1 -i encrypted.pcm encrypted.wav

# 역재생 (areverse)
ffmpeg -i encrypted.wav -af "areverse" challenge.wav
```

---

## 🔍 문제 풀이

**Step 1. 힌트 분석으로 비밀번호 추론 → `parkmiso0422`**

**Step 2. 역재생 제거**

```bash
ffmpeg -i challenge.wav -af "areverse" reversed.wav
```

**Step 3. WAV → PCM 변환**

```bash
ffmpeg -i reversed.wav -f s16le -acodec pcm_s16le reversed_raw.pcm
```

**Step 4. AES-256 복호화**

```bash
openssl enc -d -aes-256-cbc -in reversed_raw.pcm -out decrypted.pcm -k parkmiso0422
```

**Step 5. PCM → WAV 복원 및 재생**

```bash
ffmpeg -f s16le -ar 22050 -ac 1 -i decrypted.pcm fixed.wav
ffplay fixed.wav
```

음성 내용: *"This is the encrypted broadcast. The flag is ADVANCED_REVERSE_AUDIO."*

**🏁 FLAG**
```
FLAG{ADVANCED_REVERSE_AUDIO}
```
