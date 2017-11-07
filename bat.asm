.include "tn85def.inc"
  
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


#define voltage(v) low(1125.3/v)

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
  out PORTB, r17
  nop nop nop nop nop nop nop
  nop nop nop nop nop nop nop
  nop nop nop nop nop nop nop
  nop nop nop nop nop nop nop
 clr r17
  out PORTB, r17 


  rjmp loop





readADC:
    ; Enable, Start conversion, clear interrupt, Prescale 128
    ldi r16,(1<<ADEN|1<<ADSC|1<<ADIF|1<<ADPS2|1<<ADPS1|1<<ADPS0)
    out ADCSRA,r16
waitForConversion:
    sbis ADCSRA,ADIF
    rjmp waitForConversion
    in r16,ADCL
    in r0,ADCH
    ret
