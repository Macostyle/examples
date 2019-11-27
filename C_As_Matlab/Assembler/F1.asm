
section .data
    pr db `%lf`, 0
    mass dq 0
    half dq 0

section .text

global f1
f1:
    push ebp
    mov ebp, esp
    sub esp, 12 
    
    finit
    fld qword [ebp + 8]
    fldl2e
    fmulp
    frndint
    fstp qword [half]
    
    finit
    fld qword [ebp + 8]
    fldl2e
    fmulp
    fld qword [half]
    fsubp
    
    f2xm1
    fld1
    faddp
    fstp qword [mass]
    fld qword [half]
    fld1
    fscale
    fld qword [mass]
    fmulp
    fld1
    faddp
    fld1
    faddp
    fstp qword [mass]
    finit
    fld qword [mass]
    
    xor eax, eax
    leave
    ret
