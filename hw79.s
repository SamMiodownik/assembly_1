.text

    .globl relation_code
    .type relation_code, @function
relation_code:
    # TODO: Problem 1
    movq $0, %rax
    cmpq %rsi, %rdi
    jl signedless
    jb unsignedless

    
    ret
    signedless:
            addq $1, %rax
            cmpq %rsi, %rdi
            jb unsignedless
            ret
    unsignedless:
            addq $2, %rax
            ret

    .globl clamp_long
    .type clamp_long, @function
clamp_long:
    # TODO: Problem 2
    movq $0, %rax
    cmpq %rsi, %rdi
    jl clamp_low
    cmpq %rdi, %rdx
    jl clamp_high
    movq %rdi, %rax
    ret
    clamp_low:
        movq %rsi, %rax
        ret
    clamp_high:
        movq %rdx, %rax
        ret
    

    .globl weighted_sum8
    .type weighted_sum8, @function
weighted_sum8:
    # TODO: Problem 3
    movq $0, %rax
    addq %rdi, %rax
    imulq $2, %rsi
    addq %rsi, %rax
    imulq $3, %rdx
    addq %rdx, %rax
    imulq $4, %rcx
    addq %rcx, %rax
    imulq $5, %r8
    addq %r8, %rax
    imulq $6, %r9
    addq %r9, %rax
    movq 8(%rsp), %rdi
    imulq $7, %rdi 
    addq %rdi, %rax
    movq 16(%rsp), %rdi
    imulq $8, %rdi 
    addq %rdi, %rax
    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    # TODO: Problem 4
    movq $0, %rax
    cmpq $0, %rdi
    je done
    movq $1, %rdx
    loop:
        cmpq $0, %rdi
        je done
        subq $1, %rdi
        addq %rdx, %rax
        cmpq $0, %rdx
        jl negative
        jg positive
        negative:
            subq $1, %rdx
            imulq $-1, %rdx
            jmp loop
        positive:
            addq $1, %rdx
            imulq $-1, %rdx
            jmp loop

    done:
        ret

    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # TODO: Problem 5
    pushq %rbp
    movq %rsp, %rbp
    cmpq $0, %rsi
    je power_base
    subq $1, %rsi
    call recursive_power
    imulq %rdi, %rax
    leave
    ret

    power_base:
        movq $1, %rax
        leave
        ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    pushq %rbp
    movq  %rsp, %rbp
    subq  $16, %rsp
    movq  %rdi, -8(%rbp)
    movq  %rsi, -16(%rbp)
    movq  -8(%rbp), %rdi
    call  helper_square
    movq  %rax, -8(%rbp)
    movq  -16(%rbp), %rdi
    call  helper_affine
    addq  -8(%rbp), %rax
    leave
    ret

    .section .note.GNU-stack,"",@progbits
