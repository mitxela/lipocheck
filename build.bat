
"C:\!mitxela\avr8\wb\avrasm2.exe" -fI -o "C:\!mitxela\avr8\battery\bat.hex" -W+ie -I"C:\!mitxela\avr8\wb" "C:\!mitxela\avr8\battery\bat.asm"

pause

C:\Users\user\Downloads\avrdude\avrdude.exe -p t85 -B10 -c USBASP -U flash:w:"C:\!mitxela\avr8\battery\bat.hex":i 

pause