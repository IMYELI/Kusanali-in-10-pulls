global _start

section .data
    filename db 'WANGY.txt', 0
    outFile db 'wangy_generated.txt', 0
    lenOutFile equ $-outFile
    msg1 db 'masukan nama yang ingin diwangy: '
    msg1Len equ $-msg1
    nl db 0xa
    lenFile equ 1118
    text1 db '...'
    text1Len equ $-text1
    text2 db '... AAAAAAAAAAGH AAAAAAAAAAAAAAGH heartheartheartheart WANGY WANGY WANGY WANGY HU HA HU HA HU HA, aaaah baunya '
    text2Len equ $-text2
    text3 db 'wangi aku mau nyiumin aroma badan nya AAAAAAAAH ~~ Rambutnya.... aaah Rambutnya juga pengen aku acak-acak ~ AAAAAH '
    text3Len equ $-text3
    text4 db 'keluar pertama kali juga manis heartheartheart AAAAAAAAH '
    text4Len equ $-text4
    text5 db 'LUCCUUUUUUUUUUUUUUU............ GUA BAKAL BAKAR DUIT 100 JUTA RUPIAH BUAT '
    text5Len equ $-text5
    text6 db 'AAAAAAAAAAAAAGH apa ? '
    text6Len equ $-text6
    text7 db 'itu gak nyata ? Cuma karakter 2 dimensi katamu ? nggak, ngak ngak ngak ngak NGAAAAAAAAK GUA GAK PERCAYA ITU DIA NYATA NGAAAAAAAAAAAAAAAAAK !! GUA GAK PEDULI SAMA KENYATAAN POKOKNYA GAK PEDULI. '
    text7Len equ $-text7
    text8 db 'ngeliat gw ... '
    text8Len equ $-text8
    text9 db 'di laptop ngeliatin gw '
    text9Len equ $-text9
    text10 db '... kamu percaya  sama aku ? aaaaaaaaaaah syukur '
    text10Len equ $-text10
    text11 db 'gak malu merelakan aku aaaaaah heartheartheart YEAAAAAAAAAAAH GUA MASIH PUNYA '
    text11Len equ $-text11
    text12 db '. SENDIRI PUN NGGAK SAMA  AAAAAAAAAAAAAA'
    text12Len equ $-text12
    space db ' '



section .bss
    inputMsg resb 10
    fd_in resb 1
    fd_out resb 1
    isifile resb 1118
    outputFile resb 1000
    outputFileLen resb 1
    inputMsgLen resb 1

section .text

_start:
    mov ebx, filename
    call _openFile
    call _readFile

    call _print

    call _nl
    call _nl

    mov ecx, msg1
    mov edx, msg1Len
    call _print

    mov ecx, inputMsg
    mov edx, 10
    call _read
    mov ebx, eax
    dec ebx
    mov [inputMsgLen], ebx

    call _nl
    call _generateWangy
    call _nl

    call _createFile

    ;exit
    mov eax, 1
    mov ebx, 0
    int 80h


_createFile:

    ;membuat file
    mov eax, 8
    mov ebx, outFile
    mov ecx, 0777
    int 80h
    mov [fd_out], eax

    ;menulis ke file
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, outputFile
    mov edx, [outputFileLen]
    int 80h
    ret

_strlen:
    ;hasil harus di -1 jika merupakan input dari pengguna
    sub al,al
    mov ecx, 0
    
    .count:
    cmp [ebx+ecx], al
    je .end

    inc ecx
    jmp .count
    .end:
    mov eax, ecx
    ret

_addPart:
    .ngeloop:
    mov al, [esi+ebx]
    mov [outputFile+edx], al
    inc ebx
    inc edx
    cmp ebx, edi
    jne .ngeloop
    ret

_addNama:
    mov ebx, 0
    mov esi, inputMsg
    mov edi, [inputMsgLen]
    call _addPart

_addSpace:
    mov al, [space]
    mov [outputFile+edx], al 
    inc edx
    ret

_generateWangy:
    ;menyatukan seluruh teks dengan nama yang diinput
    mov ecx, 0
    mov edx, 0
    
    mov esi, inputMsg
    mov edi, [inputMsgLen]

    jmp .part1
    
    .part1a:
        call _addSpace
    .part1:
        mov ebx, 0
        call _addPart
        inc ecx
        cmp ecx, 3
        jne .part1a

    .part2:
        mov esi, text2
        mov edi, text2Len
        mov ecx, 0
        mov ebx, 0
        call _addPart

    .part3:
        call _addNama
        call _addSpace

    .part4:
        mov esi, text3
        mov edi, text3Len
        mov ebx, 0
        call _addPart

    .part5:
        call _addNama
        call _addSpace

    .part6:
        mov esi, text4
        mov edi, text4Len
        mov ebx, 0
        call _addPart
        
    .part7:
        call _addNama
        call _addSpace
    
    .part8:
        mov esi, text5
        mov edi, text5Len
        mov ebx, 0
        call _addPart
        
    .part9:
        call _addNama
        call _addSpace

    .part10:
        mov esi, text6
        mov edi, text6Len
        mov ebx, 0
        call _addPart
        
    .part11:
        call _addNama
        call _addSpace
    
    .part12:
        mov esi, text7
        mov edi, text7Len
        mov ebx, 0
        call _addPart
        
    .part13:
        call _addNama
        call _addSpace
    
    .part14:
        mov esi, text8
        mov edi, text8Len
        mov ebx, 0
        call _addPart
        
    .part15:
        call _addNama
        call _addSpace

    .part16:
        mov esi, text9
        mov edi, text9Len
        mov ebx, 0
        call _addPart
        
    .part17:
        call _addNama
        call _addSpace
    
    .part18:
        mov esi, text10
        mov edi, text10Len
        mov ebx, 0
        call _addPart
        
    .part19:
        call _addNama
        call _addSpace
    
    .part20:
        mov esi, text11
        mov edi, text11Len
        mov ebx, 0
        call _addPart
        
    .part21:
        call _addNama
        call _addSpace
    
    .part22:
        mov esi, text12
        mov edi, text12Len
        mov ebx, 0
        call _addPart

    mov ebx, outputFile
    call _strlen
    mov ecx, outputFile
    mov [outputFileLen], eax
    mov edx, eax
    call _print
    call _nl
    ret


_openFile:
    mov eax, 5
    mov ecx, 0
    mov edx, 077
    int 80h
    mov [fd_in], eax
    ret

_readFile:
    mov eax, 3 ; read file
    mov ebx, [fd_in]
    mov ecx, isifile
    mov edx, lenFile
    int 80h
    ret

_nl:
    mov ecx, nl
    mov edx, 1
    call _print
    ret
_read:
    mov eax, 3 ; read input 
    mov ebx, 0
    int 80h
    ret

_print:
    mov eax, 4  ; print
    mov ebx, 1
    int 80h
    ret