.model small
.stack 100h
.data
    prompt db '请输入1~100之间的数字: $'        ; 提示用户输入
    inputMsg db '您输入的数字是: $'             ; 显示用户输入的数字
    resultMsg db '1到该数字的累加和为: $'       ; 显示结果
    inputBuffer db 5, ?, ?, ?, ?, '$'           ; 缓存用户输入的数字 (最多5位)
    outputBuffer db 6 dup ('$')                 ; 缓存输出结果

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; 显示提示信息
    mov ah, 9
    lea dx, prompt
    int 21h

    ; 获取用户输入 (字符串形式)
    mov ah, 0Ah                ; 功能号0Ah: 从键盘缓冲区读取字符串
    lea dx, inputBuffer        ; 缓冲区地址
    int 21h

    ; 将字符串转换为数字
    mov si, offset inputBuffer + 2 ; 指向实际输入的数字部分
    xor cx, cx                   ; 累加和
    xor ax, ax                   ; 清空ax用于数字转换
convert_to_num:
    mov bl, byte ptr [si]        ; 读取一个字符
    cmp bl, 0                    ; 检查是否到字符串末尾
    je calculate_sum             ; 如果是0表示结束，跳到计算和部分
    sub bl, '0'                  ; 将字符转换为数值
    mov bh, 10                   ; 将ax乘以10，为下一位数字腾出位置
    mul bh
    add ax, bx                   ; 加上当前位的数字
    inc si                       ; 移动到下一个字符
    jmp convert_to_num

calculate_sum:
    mov cx, ax                   ; 将输入的数字存入cx，用于循环计数
    xor bx, bx                   ; 清空bx作为累加和

sum_loop:
    add bx, cx                   ; 累加当前数值
    loop sum_loop                ; 循环递减cx，直到cx为0

    ; 显示用户输入的数字
    mov ah, 9
    lea dx, inputMsg
    int 21h

    ; 将输入的数字转换成字符串显示
    mov ax, cx
    call num_to_str
    mov ah, 9
    lea dx, outputBuffer
    int 21h

    ; 显示累加和
    mov ah, 9
    lea dx, resultMsg
    int 21h

    ; 将累加和转换成字符串显示
    mov ax, bx
    call num_to_str
    mov ah, 9
    lea dx, outputBuffer
    int 21h

    ; 程序退出
    mov ah, 4Ch
    int 21h

main endp

; 数字转字符串的子程序
num_to_str proc
    mov di, offset outputBuffer + 6 ; 设置输出缓存的末尾
    mov cx, 0

convert_loop:
    mov dx, 0
    div bx                         ; 除以10得到余数
    add dl, '0'                    ; 将余数转换为字符
    dec di
    mov [di], dl                   ; 将字符存入缓存
    inc cx
    test ax, ax
    jnz convert_loop               ; 若商非0，继续除10

    mov si, di                     ; 设置si为输出字符串的开始
    ret
num_to_str endp
end main
