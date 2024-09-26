.model small
.stack 100h

.data
    newline db 13, 10, '$' ; 定义换行符

.code
start:
    mov ax, @data
    mov ds, ax

    mov bx, 0 ; BX用于计算当前字母的ASCII码
    mov cx, 2 ; 外层循环计数器，控制打印2行

outer_loop:
    push cx ; 保存外层循环的CX值
    mov cx, 13 ; 内层循环计数器，每行打印13个字符

inner_loop:
    mov dl, 'a' ; 小写字母的起始ASCII码
    add dl, bl ; 计算当前要输出的字符
    mov ah, 02h
    int 21h ; 输出字符
    inc bl ; 移动到下一个字母
    loop inner_loop ; 内层循环，如果cx不为0，继续内循环

    ; 内层循环结束，准备打印换行符
    mov ah, 09h
    lea dx, newline
    int 21h

    ; 恢复外层循环的CX值
    pop cx 
    loop outer_loop ; 外层循环，如果cx不为0，继续外循环

    ; 结束程序
    mov ax, 4C00h
    int 21h

end start