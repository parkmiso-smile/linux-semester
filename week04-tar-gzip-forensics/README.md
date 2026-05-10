# 4주차 — tar/gzip 설치하기

## 📌 개요

**tar**와 **gzip**을 활용하여, 압축 파일 내부에 숨겨진 증거 파일을 찾아내는 포렌식 CTF 문제를 제작하였다.

## ⚙️ 설치

대부분의 리눅스 배포판에 기본 설치되어 있다. 없다면:

```bash
sudo apt install tar gzip
```

### GitHub
https://github.com/parkmiso-smile/Forensics-CTF

---

## 🚩 CTF 문제

### 카테고리
Forensics

### 시나리오
```
너는 수사관이고, 범죄자의 컴퓨터에서 case_backup.tar.gz 라는 압축 파일 1개를 확보했다.
겉보기엔 평범한 프로젝트 백업처럼 보이지만 범죄자는 중요한 증거 파일을 어딘가에 숨겨놓았을 가능성이 있다.

너의 임무:
tar 파일 내부 구조를 분석하고, 숨겨진 ZIP 파일과 그 안의 FLAG를 찾아라.
```

### 관련 파일
- [make_challenge.sh](./make_challenge.sh) — 문제 파일 생성 스크립트

---

## 📖 문제 제작 과정

```bash
# 디렉토리 구조 생성
mkdir -p case_backup/project/src
mkdir -p case_backup/project/docs
mkdir -p case_backup/project/assets/data/tmp/.cfg
mkdir -p case_backup/logs

# 일반 파일 생성
echo "print('server booting...')" > case_backup/project/src/app.py
echo "# helper functions"         > case_backup/project/src/helper.py
echo "Confidential Project Documentation" > case_backup/project/docs/readme.md
echo "v1.2 changes logged"        > case_backup/project/docs/changes.txt
echo "Server log: OK"             > case_backup/logs/server.log

# FLAG 파일 생성 및 ZIP으로 숨기기
echo "FLAG{Case_Confidential_Evidence}" > secret_flag.txt
zip hidden_payload.zip secret_flag.txt
rm secret_flag.txt

# 숨겨진 경로에 이동
mv hidden_payload.zip case_backup/project/assets/data/tmp/.cfg/

# tar + gzip 압축
tar -cvf case_backup.tar case_backup/
gzip case_backup.tar
```

생성되는 디렉토리 구조:
```
case_backup/
├── logs/
│   └── server.log
└── project/
    ├── src/
    │   ├── app.py
    │   └── helper.py
    ├── docs/
    │   ├── readme.md
    │   └── changes.txt
    └── assets/
        └── data/
            └── tmp/
                └── .cfg/
                    └── hidden_payload.zip  ← FLAG가 여기에!
```

---

## 🔍 문제 풀이

**Step 1. 파일 내부 목록 확인**

```bash
tar -tf case_backup.tar.gz
```
<img width="635" height="353" alt="image" src="https://github.com/user-attachments/assets/588bb08a-a5de-43a6-ae62-23ac86e55ea2" />

`secret_flag.txt`는 보이지 않지만 의심스러운 `.zip` 파일이 보인다.

**Step 2. 압축 해제**

```bash
tar -xvf case_backup.tar.gz
cd case_backup/project/assets/data/tmp/.cfg/
ls
# hidden_payload.zip 발견
```
<img width="886" height="499" alt="image" src="https://github.com/user-attachments/assets/50cb561b-9c93-4300-a2c6-407c70c45bd5" />

**Step 3. ZIP 압축 해제**

```bash
unzip hidden_payload.zip
cat secret_flag.txt
```

**🏁 FLAG**
```
FLAG{Case_Confidential_Evidence}
```
