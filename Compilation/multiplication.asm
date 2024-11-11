.386
.model small
.stack 100h

.data
    fmt db "%d*%d=%d ", 13, 10, '$' ; �����ʽ���ַ������������з�

.code
main proc
    mov ax, @data
    mov ds, ax

    call print_multiplication_table

    mov ax, 4C00h ; ��������
    int 21h

print_multiplication_table proc
    mov cx, 9 ; ���ѭ������1��9
.outer_loop:
    push cx ; �������ѭ���ļ�����
    mov bx, cx ; �ڲ�ѭ��Ҳʹ����ͬ�ļ�����
.inner_loop:
    push bx ; �����ڲ�ѭ���ļ�����
    mov ah, 02h ; DOS�жϴ�ӡ�ַ�����
    mov dl, bl ; ��ȡ��ǰ�ĳ���
    int 21h
    mov dl, '*'
    int 21h
    mov dl, cl ; ��ȡ��ǰ�ı�����
    int 21h
    mov dl, '='
    int 21h
    mov ax, bx ; ����˻�
    mul cx
    call print_number ; ���ù��̴�ӡ����
    inc bx ; �����ڲ�ѭ���ļ�����
    cmp bx, 10
    jl .inner_loop ; ���bxС��10�������ڲ�ѭ��
    pop bx ; �ָ��ڲ�ѭ���ļ�����
    pop cx ; �ָ����ѭ���ļ�����
    loop .outer_loop ; ���cxС��10���������ѭ��
    ret
print_multiplication_table endp

; ���̣���ӡһ������
print_number proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10 ; ����
    mov cx, 0 ; ���ֵ�λ��

.print_loop:
    div bx ; ax / 10, ����ax�У�������dx��
    add dl, '0' ; ������ת��ΪASCII�ַ�
    push dx ; ������ѹ���ջ
    inc cx ; ����λ��������
    test ax, ax ; ������Ƿ�Ϊ��
    jnz .print_loop ; ������ǣ�����ѭ��

.print_digits:
    pop dx ; ��������
    mov ah, 02h ; DOS�жϴ�ӡ�ַ�����
    int 21h ; ����DOS�жϴ�ӡ�ַ�
    loop .print_digits ; �ظ�ֱ���������ֶ�����ӡ

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

main endp
end main