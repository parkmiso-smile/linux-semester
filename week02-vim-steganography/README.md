# 2주차 — Vim 설치하기

##  개요

**Vim**을 설치하고, Whitespace Steganography(공백·탭 기반 스테가노그래피) 형태의 CTF 문제를 직접 제작하였다.

##  Vim 특징

- 입력 모드·명령 모드·비주얼 모드 등 다양한 편집 모드 제공
- `:set list` 기능: 공백·탭·줄바꿈 등 보이지 않는 문자를 시각적으로 탐지 → 스테가노그래피 분석에 핵심

##  설치

```bash
sudo apt install vim
vim --version   # 설치 확인 및 버전 확인
```

---

## 🚩 CTF 문제

### 카테고리
Steganography

### 시나리오
평범해 보이는 텍스트 파일 안에 FLAG가 공백(SPACE)과 탭(TAB)으로 숨겨져 있다.  
숨겨진 데이터를 찾아 디코딩하여 FLAG를 획득하라.

### 관련 파일
- [encode_flag.py](./encode_flag.py) — FLAG를 공백/탭으로 인코딩하는 스크립트
- [problem.txt](./problem.txt) — 숨겨진 데이터가 삽입된 문제 파일


## 📖 문제 제작 과정

**1. FLAG 인코딩 스크립트 작성**

```bash
nano encode_flag.py
```

→ [encode_flag.py](./encode_flag.py) 참고

**2. 인코딩 스크립트 실행**

```bash
python3 encode_flag.py
# encoded_flag.txt 생성 완료!
```

**3. 문제 파일(problem.txt) 생성**

```bash
vim problem.txt
```

vim 내부에서 평문 내용 작성 후, 다음 명령어로 인코딩된 데이터를 삽입:

```
:r encoded_flag.txt
```

---

## 🔍 문제 풀이

**Step 1. 파일 열기**

```bash
vim problem.txt
```

**Step 2. 숨겨진 문자 시각화**
<img width="585" height="440" alt="image" src="https://github.com/user-attachments/assets/5ade4f0e-b6c4-443b-8ca1-6c0a138eeea1" />

vim 명령 모드에서:
```
:set list
```

공백은 공백, 탭은 `^I`로 표시된다.

**Step 3. 디코딩**

- 공백 → `0`
- 탭 → `1`

마지막 줄의 공백·탭 조합을 순서대로 0과 1로 변환하면 긴 이진 문자열을 얻을 수 있다.  
이 이진 문자열을 8비트씩 끊어 ASCII로 디코딩하면 FLAG가 복원된다.

예시:
- `01000110` → `F`
- `01001100` → `L`

**🏁 FLAG**
```
FLAG{Rabbit_To_Dog_we_Need_BigCarrot}
```
