; calc.asm
.386
.model flat, stdcall
.stack 100h

extern years: byte
extern revenues: dword
extern employees: word
extern table: byte

.code
calc_annual_income PROC
    mov cx, 21          ; 循环21次，对应21年的数据
    lea si, years       ; 指向年份字符串数组的开始
    lea bx, revenues    ; 指向收入数组的开始
    lea dx, employees   ; 指向员工人数数组的开始
    lea di, table       ; 指向table段的开始

calculate_loop:
    push cx            ; 保存cx寄存器的值
    mov ax, [bx]       ; 将收入加载到ax
    mov bx, [dx]       ; 将员工人数加载到bx
    div bx            ; ax除以bx得到人均收入，结果在ax，余数在dx
    add ax, 5          ; 四舍五入
    daa               ; 调整ax以反映正确的BCD加法
    stosb             ; 存储年份
    mov ax, [bx+2]     ; 存储收入
    stosd
    mov ax, [dx]       ; 存储员工人数
    stosw
    mov ax, [di-2]     ; 存储人均收入
    stosd
    pop cx            ; 恢复cx寄存器的值
    add si, 1         ; 移动到下一个年份字符串
    add bx, 4         ; 移动到下一个收入值
    add dx, 2         ; 移动到下一个员工人数值
    add di, 13        ; 移动到table的下一行
    loop calculate_loop
    ret
calc_annual_income ENDP
end