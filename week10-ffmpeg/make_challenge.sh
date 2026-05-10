#!/bin/bash
# FFmpeg CTF 문제 파일 생성 스크립트

echo "FLAG{ADVANCED_REVERSE_AUDIO}" > flag.txt

echo "[1/4] TTS로 음성 파일 생성 중..."
espeak "This is the encrypted broadcast. The flag is ADVANCED_REVERSE_AUDIO." \
    -w original.wav

echo "[2/4] WAV → RAW PCM 변환 중..."
ffmpeg -i original.wav -f s16le -acodec pcm_s16le raw.pcm -y

echo "[3/4] AES-256 암호화 중..."
openssl enc -aes-256-cbc -salt -in raw.pcm -out encrypted.pcm -k parkmiso0422
ffmpeg -f s16le -ar 44100 -ac 1 -i encrypted.pcm encrypted.wav -y

echo "[4/4] 역재생 적용 중..."
ffmpeg -i encrypted.wav -af "areverse" challenge.wav -y

echo "challenge.wav 생성 완료!"
