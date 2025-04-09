section .data
    print_fmt db "Triple: %d, %d, %d", 0xA, 0 ; Format for printf

section .text
    global _start
    extern printf

_start:
    mov rcx, 500              ; Upper limit for c (stored in RCX)

find_triples:
    ; Outer loop for c
    mov rbx, 1                ; Initialize c to 1
loop_c:
    inc rbx                   ; Increment c
    cmp rbx, rcx              ; If c > 500, exit
    jg end_program            ; End program if limit exceeded

    ; Inner loop for b
    mov rsi, 1                ; Initialize b to 1
loop_b:
    inc rsi                   ; Increment b
    cmp rsi, rbx              ; If b >= c, go to next c
    jge loop_c

    ; Innermost loop for a
    mov rdi, 1                ; Initialize a to 1
loop_a:
    inc rdi                   ; Increment a
    cmp rdi, rsi              ; If a >= b, go to next b
    jge loop_b

    ; Test if (a, b, c) is a Pythagorean triple
    push rbx                  ; Push c onto the stack
    push rsi                  ; Push b onto the stack
    push rdi                  ; Push a onto the stack
    call is_pythagorean       ; Call the function to test the triple
    add rsp, 24               ; Clean up stack (3 values x 8 bytes each)

    test rax, rax             ; Check return value (0 = false, 1 = true)
    jz loop_a                 ; If not a triple, continue

    ; Print the triple
    mov rdi, print_fmt        ; Load address of format string into RDI
    mov rsi, rdi              ; Load a into RSI (2nd argument for printf)
    mov rdx, rsi              ; Load b into RDX (3rd argument for printf)
    mov rcx, rbx              ; Load c into RCX (4th argument for printf)
    call printf               ; Call printf to print the triple

    jmp loop_a                ; Continue with the next a

end_program:
    ; Exit the program
    mov rax, 60               ; syscall: exit
    xor rdi, rdi              ; Exit code: 0
    syscall

; Function: is_pythagorean
; Checks if (a^2 + b^2 = c^2)
is_pythagorean:
    push rbp                  ; Save base pointer
    mov rbp, rsp              ; Set up stack frame

    mov rax, [rbp+16]         ; a (first parameter)
    imul rax, rax             ; Compute a^2
    mov rdx, [rbp+12]         ; b (second parameter)
    imul rdx, rdx             ; Compute b^2
    add rax, rdx              ; Compute a^2 + b^2
    mov rdx, [rbp+8]          ; c (third parameter)
    imul rdx, rdx             ; Compute c^2
    cmp rax, rdx              ; Compare a^2 + b^2 with c^2
    jne not_pythagorean       ; If not equal, return 0

    mov rax, 1                ; Return 1 (true)
    jmp end_function

not_pythagorean:
    mov rax, 0                ; Return 0 (false)

end_function:
    pop rbp                   ; Restore base pointer
    ret                       ; Return to caller

