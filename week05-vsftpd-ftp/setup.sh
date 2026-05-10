#!/bin/bash
# vsftpd CTF 환경 구성 스크립트

sudo apt install vsftpd -y

echo "[*] ftpuser 계정을 생성합니다."
sudo adduser ftpuser

echo "[*] 숨겨진 FLAG 파일 생성 중..."
echo "FLAG{find_hidden_file}" | sudo tee /home/ftpuser/.secret_flag
sudo chown ftpuser:ftpuser /home/ftpuser/.secret_flag

echo "[*] 위장용 일반 파일 생성 중..."
sudo mkdir -p /home/ftpuser/files
sudo chown ftpuser:ftpuser /home/ftpuser/files
echo "일반 문서입니다" | sudo tee /home/ftpuser/files/readme.txt
sudo chown ftpuser:ftpuser /home/ftpuser/files/readme.txt

echo "[*] vsftpd 서비스 시작..."
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

echo "환경 구성 완료! ftp 127.0.0.1 로 접속하세요."
