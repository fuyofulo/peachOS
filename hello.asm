; hello.asm - Simple bootloader that prints "Hello, World!" and halts

org 0x7c00               ; Set the origin, BIOS loads the bootloader at 0x7c00

start:
    mov si, hello_msg    ; Load the address of the message into SI
    call print_string    ; Call the print string procedure

    jmp $                ; Infinite loop to halt execution

print_string:
    lodsb                ; Load byte at SI into AL, increment SI
    cmp al, 0            ; Compare AL with 0 (end of string)
    je done              ; If zero, jump to done
    mov ah, 0x0e         ; BIOS teletype function
    int 0x10             ; Print character in AL
    jmp print_string     ; Repeat for next character

done:
    ret                  ; Return from procedure (not necessary here, but good practice)

hello_msg db 'Hello, World!', 0 ; The message to print

times 510 - ($ - $$) db 0 ; Fill the rest of the sector with zeros
dw 0xaa55                 ; Boot sector signature

