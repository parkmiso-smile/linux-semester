FLAG = "FLAG{Rabbit_To_Dog_we_Need_BigCarrot}"

# 1) FLAG → 8비트 바이너리 변환
binary = ''.join(format(ord(c), '08b') for c in FLAG)

# 2) 바이너리 → 공백/탭 변환
encoded = ''
for b in binary:
    if b == '0':
        encoded += ' '   # 공백
    else:
        encoded += '\t'  # 탭

# 3) encoded_flag.txt 파일로 저장
with open("encoded_flag.txt", "w") as f:
    f.write(encoded)

print("encoded_flag.txt 생성 완료!")
