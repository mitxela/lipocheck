.include "tn85def.inc"
rjmp init

.org 0x0008 ; ADC
  
  rjmp sleepDone


init:

.def displayTime = r21
  ldi displayTime,80

  ldi r16, 1<<PRTIM1 | 1<<PRTIM0 | 1<<PRUSI
  out PRR, r16


  ldi r16, $ff
  out DDRB, r16

  ldi r16, 0b0000_1100
  out ADMUX, r16

  ldi r16, (1<<ADEN)|3
  out ADCSRA, r16

  clr XH
wait1:
  sbiw X, 1
  brne wait1


#define voltage(v) low((1.1*1024)/v)

loop:

  rcall readADC

  clr r17
  out PORTB, r17
  ldi r18,1

  cpi r16, voltage(3.0)
  cpc r0,r18
  brcc wait2

  sbi PORTB, PB0
  cpi r16, voltage(3.7)
  cpc r0,r18
  brcc wait2

  sbi PORTB, PB1
  cpi r16, voltage(3.75)
  cpc r0,r18
  brcc wait2

  sbi PORTB, PB2
  cpi r16, voltage(3.9)
  cpc r0,r18
  brcc wait2

  sbi PORTB, PB3


wait2:

  clr XH
wait3:
  sbiw X, 1
  brne wait3


  clr r17
  out PORTB, r17 


  dec displayTime
  brne loop

  sleep ; wake up by reset pin




readADC:
    ; Enable, clear interrupt, interrupt enable, Prescale 128
    ldi r16,(1<<ADEN|1<<ADIF|1<<ADIE|1<<ADPS2|1<<ADPS1|1<<ADPS0)
    out ADCSRA,r16
    ldi r16, 1<<SE | 1<<SM0 ; ADC sleep mode
    out MCUCR, r16
    sei
    sleep
sleepDone:
    cli
    pop r0
    pop r0

waitForConversion:
    sbic ADCSRA,ADSC
    rjmp waitForConversion
    in r16,ADCL
    in r0,ADCH
    ret
