.386
.model small
.stack 100h

.data
    fmt db "%d*%d=%d ", 13, 10, '$' ; 定义格式化字符串，包括换行符

.code
main proc
    mov ax, @data
    mov ds, ax

    call print_multiplication_table

    mov ax, 4C00h ; 结束程序
    int 21h

print_multiplication_table proc
    mov cx, 9 ; 外层循环，从1到9
.outer_loop:
    push cx ; 保存外层循环的计数器
    mov bx, cx ; 内层循环也使用相同的计数器
.inner_loop:
    push bx ; 保存内层循环的计数器
    mov ah, 02h ; DOS中断打印字符功能
    mov dl, bl ; 获取当前的乘数
    int 21h
    mov dl, '*'
    int 21h
    mov dl, cl ; 获取当前的被乘数
    int 21h
    mov dl, '='
    int 21h
    mov ax, bx ; 计算乘积
    mul cx
    call print_number ; 调用过程打印数字
    inc bx ; 增加内层循环的计数器
    cmp bx, 10
    jl .inner_loop ; 如果bx小于10，继续内层循环
    pop bx ; 恢复内层循环的计数器
    pop cx ; 恢复外层循环的计数器
    loop .outer_loop ; 如果cx小于10，继续外层循环
    ret
print_multiplication_table endp

; 过程：打印一个数字
print_number proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10 ; 除数
    mov cx, 0 ; 数字的位数

.print_loop:
    div bx ; ax / 10, 商在ax中，余数在dx中
    add dl, '0' ; 将余数转换为ASCII字符
    push dx ; 将余数压入堆栈
    inc cx ; 增加位数计数器
    test ax, ax ; 检查商是否为零
    jnz .print_loop ; 如果不是，继续循环

.print_digits:
    pop dx ; 弹出余数
    mov ah, 02h ; DOS中断打印字符功能
    int 21h ; 调用DOS中断打印字符
    loop .print_digits ; 重复直到所有数字都被打印

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

main endp
end main