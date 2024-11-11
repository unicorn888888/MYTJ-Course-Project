; check.asm
.386
.model small
.stack 100h

extern table: byte

.data
    correct db "Correct$"
    incorrect db "Incorrect at position (%d,%d): Expected %d, Found %d$"

.code
main proc
    mov ax, @data
    mov ds, ax

    call check_table

    mov ax, 4C00h ; 结束程序
    int 21h

check_table proc
    mov cx, 9 ; 外层循环，从1到9
    lea si, table ; 指向table的开始

check_row:
    push cx ; 保存cx寄存器的值
    mov bx, cx ; 内层循环也使用相同的计数器
    mov dx, 1 ; 初始化乘数

check_col:
    push bx dx ; 保存bx和dx寄存器的值
    mov ax, dx
    mul bx
    cmp al, [si] ; 比较计算结果与table中的数据
    jne incorrect
    cmp ah, [si+1] ; 比较计算结果与table中的数据（如果结果超过255）
    jne incorrect
    add si, 2 ; 移动到下一个数据
    inc dx ; 增加乘数
    cmp dx, 10
    jl check_col

    pop dx bx ; 恢复bx和dx寄存器的值
    pop cx ; 恢复cx寄存器的值
    add si, 18 ; 移动到下一行的开始
    loop check_row
    jmp done

incorrect:
    pop dx bx ; 恢复bx和dx寄存器的值
    mov ax, bx
    inc ax
    mov bx, dx
    inc bx
    push ax bx ; 保存行和列的值
    push ax bx ; 再次保存行和列的值
    push ax ; 保存预期值
    push dx ; 保存实际值
    call print_incorrect
    pop dx
    pop ax
    pop bx
    pop ax
    jmp check_col

print_incorrect proc
    push ax bx cx dx si di
    mov ah, 09h
    lea dx, incorrect
    int 21h
    pop si di
    mov ah, 02h
    mov dl, si
    int 21h
    mov dl, ','
    int 21h
    mov dl, dh
    int 21h
    mov dl, ':'
    int 21h
    mov dl, dl
    int 21h
    mov dl, ','
    int 21h
    mov dl, dh
    int 21h
    mov dl, ':'
    int 21h
    mov dl, dl
    int 21h
    mov dl, '$'
    int 21h
    pop di cx dx bx ax
    ret
print_incorrect endp

done:
    mov ah, 09h
    lea dx, correct
    int 21h
    ret
check_table endp

main endp
end main