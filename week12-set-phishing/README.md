# 12주차 — SET (Social Engineering Toolkit) 설치하기

## 📌 개요

**SET(Social Engineering Toolkit)** 을 설치하고, Google 피싱 로그인 페이지 제작 실습을 진행하였다.

SET은 오픈소스 침투 테스트 도구로, 소셜 엔지니어링 공격 시나리오를 자동화·시뮬레이션하도록 설계되었다.

## ⚙️ 설치

```bash
git clone https://github.com/trustedsec/social-engineer-toolkit.git
cd social-engineer-toolkit
sudo python3 setup.py install
```

## 실행

```bash
sudo setoolkit
```

---

## 🚩 실습 내용

### 피싱 페이지 제작

SET 메뉴 선택 순서:
1. **Social-Engineering Attacks** → 사람을 속이는 공격 기법 메뉴
2. **Website Attack Vectors** → 웹 기반 피싱/클로닝 메뉴
3. **Credential Harvester Attack Method** → 로그인 정보(ID/PW) 탈취
4. **Web Templates** → 미리 만들어진 템플릿 사용
5. **Google** 선택 → 구글 로그인 페이지 자동 복제

### 결과 확인

```bash
ip a   # 가상머신 IP 확인 (예: 192.168.56.101)
```

브라우저에서 `http://192.168.56.101` 접속 → 구글 로그인 페이지와 유사한 피싱 페이지 확인.

---

## ⚠️ 실습 한계 및 분석

Google Sign in 버튼 클릭 시 의도한 `post.php`가 아닌 Google 실제 서버로 이동하는 문제가 발생하였다.

**원인 분석:**
- 구글 로그인 페이지는 단순 HTML 폼이 아닌, 자바스크립트가 로그인 과정 전체를 제어하는 동적 구조
- CSRF 토큰, OAuth 인증 값, 보안 쿠키 검증 등 복잡한 보안 절차 포함
- SET의 단순 클론 방식으로는 이를 우회하거나 재현 불가

→ 현대 웹 서비스의 보안 구조가 단순 피싱 클론을 효과적으로 방어하고 있음을 확인.

---

## ⚠️ 주의사항

본 실습은 **교육 목적의 실습 환경**에서만 진행되었습니다.  
실제 서비스나 타인을 대상으로 피싱 공격을 수행하는 것은 **불법**입니다.
