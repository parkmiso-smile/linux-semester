#!/bin/bash
# 문제 파일 생성 스크립트

mkdir -p case_backup/project/src
mkdir -p case_backup/project/docs
mkdir -p case_backup/project/assets/data/tmp/.cfg
mkdir -p case_backup/logs

echo "print('server booting...')"       > case_backup/project/src/app.py
echo "# helper functions"               > case_backup/project/src/helper.py
echo "Confidential Project Documentation" > case_backup/project/docs/readme.md
echo "v1.2 changes logged"              > case_backup/project/docs/changes.txt
echo "Server log: OK"                   > case_backup/logs/server.log

echo "FLAG{Case_Confidential_Evidence}" > secret_flag.txt
zip hidden_payload.zip secret_flag.txt
rm secret_flag.txt

mv hidden_payload.zip case_backup/project/assets/data/tmp/.cfg/

tar -cvf case_backup.tar case_backup/
gzip case_backup.tar

echo "challenge file: case_backup.tar.gz 생성 완료!"
