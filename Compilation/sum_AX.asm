.model small
.stack 100h

.data
    sum dw 0       ; ���ڴ洢�͵ı���
    buffer db 6 dup('$') ; ����6���ֽڵĻ����������ڴ洢�����ַ���
    message db 'The sum is: $' ; ��ӡ����Ϣ

.code
start:
    mov ax, @data
    mov ds, ax

    mov cx, 1       ; ��ʼ��������Ϊ1
    mov bx, 100     ; ��ʼ������ֵ

; ��ʼѭ�������
calculate_sum:
    add sum, cx     ; ���������ӵ�����
    inc cx         ; ���Ӽ�����
    cmp cx, bx      ; ���������Ƿ�ﵽ����ֵ
    jl calculate_sum ; ���û�У�����ѭ��

; ����ת��Ϊ�ַ���
    mov ax, sum
    mov si, offset buffer + 5 ; ָ�򻺳�����ĩβ
    mov bx, 10           ; ������ʮ���ƣ�
    mov cx, 0            ; ���ֵ�λ��

convert_to_string:
    div bx               ; ax / 10, ����ax�У�������dx��
    add dl, '0'          ; ������ת��ΪASCII�ַ�
    mov [si], dl         ; ���ַ��洢��������
    dec si               ; �ƶ�������������һ��λ��
    inc cx               ; ����λ��������
    test ax, ax          ; ������Ƿ�Ϊ��
    jnz convert_to_string ; ������ǣ�����ѭ��

; ��ӡ��Ϣ
    mov dx, offset message
    mov ah, 09h
    int 21h

; ��ӡ�����ַ���
    mov dx, si
    mov ah, 09h
    int 21h

; ��ӡ����
    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov ax, 4C00h        ; �˳�����
    int 21h

newline db 0Dh, 0Ah, '$' ; �����ַ�

end start