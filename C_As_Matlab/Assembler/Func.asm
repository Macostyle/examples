section .data

    mass dq 1

section .text

global f4
global f5
global f6

f4:
    push ebp
    mov ebp, esp
    sub esp, 12

    finit
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp
    fstp qword [mass]
    fld1
    fld1
    faddp
    fld qword [ebp + 8]
    fmulp
    fld qword [mass]
    faddp
    fld1
    faddp

    leave
    ret


f5:
    push ebp
    mov ebp, esp
    sub esp, 12

    finit
    fld1
    fld1
    faddp
    fld1
    faddp
    fld qword [ebp + 8]
    faddp
    fstp qword [mass]
    fld qword [mass]
    fld qword [mass]
    fmulp
    fld qword [mass]
    fmulp
    
    leave
    ret


f6:
    push ebp
    mov ebp, esp
    sub esp, 12

    finit
    fld1
    fld1
    faddp
    fld qword [ebp + 8]
    fmulp
    fstp qword [mass]
    fld1
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld1
    faddp
    fld qword [mass]
    faddp

    leave
    ret
