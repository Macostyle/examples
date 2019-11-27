

section .data
    pr db `%lf`, 0
    mass dq 1
    a dd 2
    b dd 3

section .text

global f3
f3:
    push ebp
    mov ebp, esp
    sub esp, 12
    
    finit
    fld qword [ebp + 8]
    fld1
    faddp
    fld dword [a]
    fmulp
    fld dword [b]
    fdivp
    fchs
    fst qword [mass]
    finit 
    fld qword [mass]
    
    xor eax, eax
    leave
    ret
