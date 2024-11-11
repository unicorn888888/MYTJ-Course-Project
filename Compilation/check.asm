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

    mov ax, 4C00h ; ��������
    int 21h

check_table proc
    mov cx, 9 ; ���ѭ������1��9
    lea si, table ; ָ��table�Ŀ�ʼ

check_row:
    push cx ; ����cx�Ĵ�����ֵ
    mov bx, cx ; �ڲ�ѭ��Ҳʹ����ͬ�ļ�����
    mov dx, 1 ; ��ʼ������

check_col:
    push bx dx ; ����bx��dx�Ĵ�����ֵ
    mov ax, dx
    mul bx
    cmp al, [si] ; �Ƚϼ�������table�е�����
    jne incorrect
    cmp ah, [si+1] ; �Ƚϼ�������table�е����ݣ�����������255��
    jne incorrect
    add si, 2 ; �ƶ�����һ������
    inc dx ; ���ӳ���
    cmp dx, 10
    jl check_col

    pop dx bx ; �ָ�bx��dx�Ĵ�����ֵ
    pop cx ; �ָ�cx�Ĵ�����ֵ
    add si, 18 ; �ƶ�����һ�еĿ�ʼ
    loop check_row
    jmp done

incorrect:
    pop dx bx ; �ָ�bx��dx�Ĵ�����ֵ
    mov ax, bx
    inc ax
    mov bx, dx
    inc bx
    push ax bx ; �����к��е�ֵ
    push ax bx ; �ٴα����к��е�ֵ
    push ax ; ����Ԥ��ֵ
    push dx ; ����ʵ��ֵ
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