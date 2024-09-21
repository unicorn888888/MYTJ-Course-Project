.model small

.data
    strs DB 'hello world', 13, 10, '$'  ; 字符串以换行结束
    msg DB 'Press any key to continue...$'  ; 提示信息

.code
start:
    mov ax, @data        ; 初始化数据段
    mov ds, ax

    ; 输出字符串
    mov dx, offset strs
    mov ah, 09h         ; DOS 功能 09h - 输出字符串
    int 21h

    ; 输出提示信息
    mov dx, offset msg
    mov ah, 09h         ; DOS 功能 09h - 输出字符串
    int 21h

    ; 等待按键
    mov ah, 01h         ; DOS 功能 01h - 输入字符
    int 21h

    ; 退出程序
    mov ah, 4ch         ; DOS 功能 4Ch - 退出程序
    int 21h

end start