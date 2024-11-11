.model small
.stack 100h

.data
    result db 'The sum of 1 + 2 + ... + 100 is: $' ; 定义字符串以显示计算结果
    num db '0000$' ; 5 个字符长度，存放结果字符串

.code
main:
    ; 初始化数据段
    mov ax, @data
    mov ds, ax

    ; 计算 1 + 2 + ... + 100
    mov cx, 100          ; CX = 100
    xor ax, ax           ; 清零 AX，用于存储结果

sum_loop:
    add ax, cx           ; AX = AX + CX
    loop sum_loop        ; CX = CX - 1, 跳转到 sum_loop

    ; 结果在 AX 中，现在将其转换为字符串并打印
    ; 将 AX 中的结果转换为字符格式
    mov bx, 10           ; 使用 10 进制
    lea di, num + 4      ; 指向 num 字符数组的最后一个位置

convert_to_ascii:
    xor dx, dx           ; 清除 DX
    div bx               ; AX / 10, 商在 AX 中，余数在 DX 中
    add dl, '0'          ; 将余数转换为 ASCII 字符
    dec di               ; 指向前一个字符
    mov [di], dl         ; 存储字符
    test ax, ax          ; 判断商是否为零
    jnz convert_to_ascii ; 如果商不为零，则继续转换

    ; 打印字符串
    mov ah, 09h          ; DOS 功能 9: 打印字符串
    lea dx, result       ; 显示计算的字符串
    int 21h

    lea dx, num          ; 显示结果
    int 21h

    ; 退出程序
    mov ah, 4Ch
    int 21h

end main
