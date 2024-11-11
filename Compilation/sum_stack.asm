.model small
.stack 100h

.data
    message db 'The sum is: $' ; ��ӡ����Ϣ

.code
start:
    mov ax, @data
    mov ds, ax

    mov cx, 1       ; ��ʼ��������Ϊ1
    mov bx, 100     ; ��ʼ������ֵ

; ��ʼѭ�������
calculate_sum:
    add word ptr [bp + 2], cx ; ���������ӵ�ջ�еĺ�
    inc cx         ; ���Ӽ�����
    cmp cx, bx      ; ���������Ƿ�ﵽ����ֵ
    jl calculate_sum ; ���û�У�����ѭ��

; ����ת��Ϊ�ַ���
    mov ax, [bp + 2]
    mov bx, 10           ; ������ʮ���ƣ�
    mov cx, 0            ; ���ֵ�λ��
    mov dx, 0            ; ����

convert_to_string:
    div bx               ; ax / 10, ����ax�У�������dx��
    add dl, '0'          ; ������ת��ΪASCII�ַ�
    push dx              ; ������ѹ���ջ
    inc cx               ; ����λ��������
    test ax, ax          ; ������Ƿ�Ϊ��
    jnz convert_to_string ; ������ǣ�����ѭ��

; ��ӡ��Ϣ
    mov dx, offset message
    mov ah, 09h
    int 21h

; ��ӡ�����ַ���
    mov ah, 02h
print_number:
    pop dx               ; ��������
    or dl, dl            ; ���dl�Ƿ�Ϊ0
    jz print_done
    int 21h
    jmp print_number

print_done:

; ��ӡ����
    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov ax, 4C00h        ; �˳�����
    int 21h

newline db 0Dh, 0Ah, '$' ; �����ַ�

end start