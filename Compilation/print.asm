; print.asm
.386
.model flat, stdcall
.stack 100h

extern table: byte

.code
print_table PROC
    mov cx, 21          ; 循环21次，对应21年的数据
    lea dx, table       ; 指向table段的开始

print_loop:
    push cx            ; 保存cx寄存器的值
    mov ah, 09h        ; DOS中断调用功能号9，用于打印字符串
    int 21h            ; 调用DOS中断
    add dx, 13         ; 移动到下一行
    pop cx            ; 恢复cx寄存器的值
    loop print_loop
    ret
print_table ENDP
end