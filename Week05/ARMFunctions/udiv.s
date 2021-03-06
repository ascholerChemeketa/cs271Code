/*
   Demonstrates using unsigned division function to make ideal change for 
   the number of cents loaded in r0.
   
   Answer provided as:
      r6: quarters
      r7: dimes
      r8: nickles
      r9: pennies
*/

.text
.global _start
_start:

   @Initial number of cents
   MOV   r0, #92

   @25 cents per quarter
   MOV   r1, #25
   BL    udiv           @ cents / 25
   @r0 now has quarters and r1 leftover cents
   MOV   r6, r0         @r6 = num quarters
   MOV   r0, r1         @put leftover cents back into r0

   @10 cents per dime
   MOV   r1, #10
   BL    udiv           @leftover cents / 10
   @r0 now has dimes needed and r1 leftover cents
   MOV   r7, r0         @r7 = num dimes
   MOV   r0, r1         @put leftover cents back into r0

   @5 cents per nickle
   MOV   r1, #5
   BL    udiv           @leftover cents / 5
   @r0 now has nickles needed and r1 leftover cents
   MOV   r8, r0         @r8 = num nickles

   MOV   r9, r1         @r9 = pennies = leftover cents

end:
   B     end            @stop here

@----------------------------------------------------------------------
/*Unsigned division - assumes both values are unsigned integers
Params:
r0 = number
r1 = divisor
Return:
r0 = quotient
r1 = remainder
*/
udiv:
   MOV   r2, #0            @temp_quotient
   B     udiv_test
udiv_loop_start:
   SUB   r0, r0, r1        @number -= divisor
   ADD   r2, r2, #1        @quotient++
udiv_test:
   CMP   r0, r1            @is remaining value > divisor?
   @Can't use GE for unsigned values
   BCS   udiv_loop_start   @if higher or same continue loop

   MOV   r1, r0            @remainder = leftover part of number
   MOV   r0, r2            @quotient = temp_quotient
   MOV   pc, lr            @return