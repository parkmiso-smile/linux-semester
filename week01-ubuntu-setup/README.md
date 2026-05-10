# 1주차 — Ubuntu 설치하기

## 📌 개요

보안 학습과 CTF 문제 제작을 위한 실습 환경 구축.  
VMware Workstation Player 위에 **Ubuntu 22.04 LTS (64-bit)** 를 설치하였다.

## 🔧 설치 사양

| 항목 | 설정값 |
|------|--------|
| Memory | 4 GB |
| Processors | 2 |
| Hard Disk (SCSI) | 20 GB |
| Network Adapter | NAT |
| USB Controller | Present |
| Sound Card | Auto detect |
| Display | Auto detect |

## 🐧 Ubuntu를 선택한 이유

- 안정적인 LTS(Long Term Support) 제공
- 활발한 커뮤니티 및 다양한 보안 도구 패키지 지원
- 파일 시스템·권한 체계·네트워크 서비스를 세밀하게 제어 가능
- 웹 해킹·포렌식·리버스 엔지니어링 등 CTF 도구 대부분이 리눅스 기반
- Bash 스크립트를 활용한 자동화로 CTF 문제 환경 구축·관리 효율적

## 🖥️ VM을 사용하는 이유

- 호스트 OS(Windows)에 영향 없이 root 권한 실험, 서버 구축, 보안 취약점 재현 가능
- 스냅샷 기능으로 설정 오류 시 즉시 이전 상태로 복구 가능

## ⚙️ 설치 과정 요약

**1. Ubuntu ISO 다운로드**
```
https://ubuntu.com/download
```

**2. VMware 가상 머신 생성**
- "Create a New Virtual Machine" 클릭
- ISO 파일 지정 후 Ubuntu 자동 인식
- 메모리·CPU·디스크 용량 설정

**3. Ubuntu 설치 진행**
- GUI 기반 설치 마법사로 지역/언어/계정 설정
- 설치 완료 후 재시작 및 초기 셋업

## 📅 향후 계획

다음 주차부터 `curl`, `vim`, `tar/gzip`, `netcat`, `Docker` 등 리눅스 도구를 설치하고, 각 도구를 활용하여 실제 CTF 문제를 직접 제작하며 보안 개념을 학습할 예정이다.
