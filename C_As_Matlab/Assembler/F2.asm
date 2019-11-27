

section .data
    pr db `%lf`, 0
    mass dq 1

section .text

global f2
f2:
    push ebp
    mov ebp, esp
    sub esp, 12

    finit
    fld1
    fld qword [ebp + 8]
    fdivp
    fchs
    fstp qword [mass]
    finit
    fld qword [mass]
    
    xor eax, eax
    leave
    ret
