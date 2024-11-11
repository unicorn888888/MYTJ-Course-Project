.model small
.stack 100h

.data
    sum dw 0       ; 用于存储和的变量
    buffer db 6 dup('$') ; 分配6个字节的缓冲区，用于存储数字字符串
    message db 'The sum is: $' ; 打印的消息

.code
start:
    mov ax, @data
    mov ds, ax

    mov cx, 1       ; 初始化计数器为1
    mov bx, 100     ; 初始化结束值

; 开始循环计算和
calculate_sum:
    add sum, cx     ; 将计数器加到和中
    inc cx         ; 增加计数器
    cmp cx, bx      ; 检查计数器是否达到结束值
    jl calculate_sum ; 如果没有，继续循环

; 将和转换为字符串
    mov ax, sum
    mov si, offset buffer + 5 ; 指向缓冲区的末尾
    mov bx, 10           ; 除数（十进制）
    mov cx, 0            ; 数字的位数

convert_to_string:
    div bx               ; ax / 10, 商在ax中，余数在dx中
    add dl, '0'          ; 将余数转换为ASCII字符
    mov [si], dl         ; 将字符存储到缓冲区
    dec si               ; 移动到缓冲区的下一个位置
    inc cx               ; 增加位数计数器
    test ax, ax          ; 检查商是否为零
    jnz convert_to_string ; 如果不是，继续循环

; 打印消息
    mov dx, offset message
    mov ah, 09h
    int 21h

; 打印数字字符串
    mov dx, si
    mov ah, 09h
    int 21h

; 打印新行
    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov ax, 4C00h        ; 退出程序
    int 21h

newline db 0Dh, 0Ah, '$' ; 新行字符

end start