.model small
.stack 100h

.data
    result db 'The sum of 1 + 2 + ... + 100 is: $' ; �����ַ�������ʾ������
    num db '0000$' ; 5 ���ַ����ȣ���Ž���ַ���

.code
main:
    ; ��ʼ�����ݶ�
    mov ax, @data
    mov ds, ax

    ; ���� 1 + 2 + ... + 100
    mov cx, 100          ; CX = 100
    xor ax, ax           ; ���� AX�����ڴ洢���

sum_loop:
    add ax, cx           ; AX = AX + CX
    loop sum_loop        ; CX = CX - 1, ��ת�� sum_loop

    ; ����� AX �У����ڽ���ת��Ϊ�ַ�������ӡ
    ; �� AX �еĽ��ת��Ϊ�ַ���ʽ
    mov bx, 10           ; ʹ�� 10 ����
    lea di, num + 4      ; ָ�� num �ַ���������һ��λ��

convert_to_ascii:
    xor dx, dx           ; ��� DX
    div bx               ; AX / 10, ���� AX �У������� DX ��
    add dl, '0'          ; ������ת��Ϊ ASCII �ַ�
    dec di               ; ָ��ǰһ���ַ�
    mov [di], dl         ; �洢�ַ�
    test ax, ax          ; �ж����Ƿ�Ϊ��
    jnz convert_to_ascii ; ����̲�Ϊ�㣬�����ת��

    ; ��ӡ�ַ���
    mov ah, 09h          ; DOS ���� 9: ��ӡ�ַ���
    lea dx, result       ; ��ʾ������ַ���
    int 21h

    lea dx, num          ; ��ʾ���
    int 21h

    ; �˳�����
    mov ah, 4Ch
    int 21h

end main
