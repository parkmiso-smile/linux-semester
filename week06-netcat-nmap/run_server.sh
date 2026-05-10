#!/bin/bash
# Hidden Port CTF 서버 실행 스크립트

echo "FLAG{Scan_To_Find_The_Secret_Port}" > flag.txt
echo "[*] 23456 포트에서 FLAG 서버를 시작합니다..."
cat flag.txt | nc -lvp 23456
