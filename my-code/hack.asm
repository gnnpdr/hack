.model tiny
.code
org 100h

start:      call    intro
            
            mov     ah, 0ah
            mov     dx, offset password
            int     21h

            mov     ah, 09h
            mov     dx, offset newstring
            int     21h

            jmp     data
password:   db      8 dup ('$')
data:       
            mov     si, offset password
            add     si, 02h
            
;HASH
            mov     cx, 8h
            xor     ax, ax
            xor     dx, dx

full:       inc     cx
            push    cx
            mov     cx, 03h
            push    ax
            xor     ax, ax                          ;null ax
            xor     dx, dx

next:       lodsb                                   ;symb code is in al

            cmp     al, 0Dh                         ;if end - enter
            je      hashend

            mov     bl, 09h
            div     bl                              ;remainder is in ah

            mov     al, ah
            mov     ah, 00h                         ;remainder is in al, so ax = 00XX

            xchg    dx, ax                          ;remainder is in dx, main dig in ax

            mov     bl, 10
            mul     bl                              ;new 0

            add     ax, dx                          ;little sum
            xchg    ax, dx                          ;main dig is in dx

            loop    next

            pop     ax  
            add     ax, dx                          ;sum is in ax 

            pop     cx
            sub     cx, 03h                        
            loop    full
            
hashend:    pop     ax                              ;return stack
            add     ax, dx                          
            xchg    ax, dx                          ;hash
            pop     cx

            mov     ah, 09h

            cmp     dx, 1cfh
            je      goodpass

            mov     dx, offset wrong
            int     21h

            mov     ah, 4ch
            int     21h

goodpass:   mov     ah, 09h
            mov     dx, offset right
            int     21h

            mov     ah, 4ch
            int     21h

intro       proc

            mov     ah, 09h                                       
            mov     dx, offset greetings
            int     21h

            mov     dx, offset passrequest
            int     21h

            ret
            endp

greetings:      db '*******************************************', 0Dh, 0Ah, '*                                         *', 0Dh, 0Ah, '*  If you want to open this super secret  *', 0Dh, 0Ah, '*               and COOL                  *', 0Dh, 0Ah,'* program, you should enter the password! *', 0Dh, 0Ah, '*                                         *', 0Dh, 0Ah,'*******************************************', 0Dh, 0Ah, '$'
passrequest:    db 'So, you think password is...$'
newstring:      db 0Dh, 0Ah, '$'
right:          db 'YEP!! You are right It s so cool, my man!$'
wrong:          db 'No...$'

end         start