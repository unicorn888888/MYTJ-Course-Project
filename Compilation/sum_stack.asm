.model small
.stack 100h

.data
    message db 'The sum is: $' ; 打印的消息

.code
start:
    mov ax, @data
    mov ds, ax

    mov cx, 1       ; 初始化计数器为1
    mov bx, 100     ; 初始化结束值

; 开始循环计算和
calculate_sum:
    add word ptr [bp + 2], cx ; 将计数器加到栈中的和
    inc cx         ; 增加计数器
    cmp cx, bx      ; 检查计数器是否达到结束值
    jl calculate_sum ; 如果没有，继续循环

; 将和转换为字符串
    mov ax, [bp + 2]
    mov bx, 10           ; 除数（十进制）
    mov cx, 0            ; 数字的位数
    mov dx, 0            ; 余数

convert_to_string:
    div bx               ; ax / 10, 商在ax中，余数在dx中
    add dl, '0'          ; 将余数转换为ASCII字符
    push dx              ; 将余数压入堆栈
    inc cx               ; 增加位数计数器
    test ax, ax          ; 检查商是否为零
    jnz convert_to_string ; 如果不是，继续循环

; 打印消息
    mov dx, offset message
    mov ah, 09h
    int 21h

; 打印数字字符串
    mov ah, 02h
print_number:
    pop dx               ; 弹出余数
    or dl, dl            ; 检查dl是否为0
    jz print_done
    int 21h
    jmp print_number

print_done:

; 打印新行
    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov ax, 4C00h        ; 退出程序
    int 21h

newline db 0Dh, 0Ah, '$' ; 新行字符

end start