#!/bin/bash
# Hydra/OpenSSH CTF 환경 구성 스크립트

sudo apt install hydra openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

echo "[*] 테스트 계정 hydratest를 생성합니다 (비밀번호: miso1234)"
sudo adduser hydratest
echo "hydratest:miso1234" | sudo chpasswd

echo "환경 구성 완료!"
echo "실행: hydra -l hydratest -P pwlist.txt ssh://127.0.0.1"
