/*
Demonstrates various sections typically available in a program

.data   : global data storage
.rodata : read only global information
.bss    : uninitialized global storage
.text   : code
*/

.section       .data
.word   0xC

.section       .rodata
MY_CONSTANT:   .word   0x64

.section       .bss
uninitializedGlobal:   .space  4

.text
.global start
_start:
@Do nothing...
MOV   r1, #0xFF
MOV   r2, #0xFF
MOV   r3, #0xFF
MOV   r4, #0xFF

end:  b end       @stop program