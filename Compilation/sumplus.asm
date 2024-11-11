.model small
.stack 100h
.data
    prompt db '������1~100֮�������: $'        ; ��ʾ�û�����
    inputMsg db '�������������: $'             ; ��ʾ�û����������
    resultMsg db '1�������ֵ��ۼӺ�Ϊ: $'       ; ��ʾ���
    inputBuffer db 5, ?, ?, ?, ?, '$'           ; �����û���������� (���5λ)
    outputBuffer db 6 dup ('$')                 ; ����������

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; ��ʾ��ʾ��Ϣ
    mov ah, 9
    lea dx, prompt
    int 21h

    ; ��ȡ�û����� (�ַ�����ʽ)
    mov ah, 0Ah                ; ���ܺ�0Ah: �Ӽ��̻�������ȡ�ַ���
    lea dx, inputBuffer        ; ��������ַ
    int 21h

    ; ���ַ���ת��Ϊ����
    mov si, offset inputBuffer + 2 ; ָ��ʵ����������ֲ���
    xor cx, cx                   ; �ۼӺ�
    xor ax, ax                   ; ���ax��������ת��
convert_to_num:
    mov bl, byte ptr [si]        ; ��ȡһ���ַ�
    cmp bl, 0                    ; ����Ƿ��ַ���ĩβ
    je calculate_sum             ; �����0��ʾ��������������Ͳ���
    sub bl, '0'                  ; ���ַ�ת��Ϊ��ֵ
    mov bh, 10                   ; ��ax����10��Ϊ��һλ�����ڳ�λ��
    mul bh
    add ax, bx                   ; ���ϵ�ǰλ������
    inc si                       ; �ƶ�����һ���ַ�
    jmp convert_to_num

calculate_sum:
    mov cx, ax                   ; ����������ִ���cx������ѭ������
    xor bx, bx                   ; ���bx��Ϊ�ۼӺ�

sum_loop:
    add bx, cx                   ; �ۼӵ�ǰ��ֵ
    loop sum_loop                ; ѭ���ݼ�cx��ֱ��cxΪ0

    ; ��ʾ�û����������
    mov ah, 9
    lea dx, inputMsg
    int 21h

    ; �����������ת�����ַ�����ʾ
    mov ax, cx
    call num_to_str
    mov ah, 9
    lea dx, outputBuffer
    int 21h

    ; ��ʾ�ۼӺ�
    mov ah, 9
    lea dx, resultMsg
    int 21h

    ; ���ۼӺ�ת�����ַ�����ʾ
    mov ax, bx
    call num_to_str
    mov ah, 9
    lea dx, outputBuffer
    int 21h

    ; �����˳�
    mov ah, 4Ch
    int 21h

main endp

; ����ת�ַ������ӳ���
num_to_str proc
    mov di, offset outputBuffer + 6 ; ������������ĩβ
    mov cx, 0

convert_loop:
    mov dx, 0
    div bx                         ; ����10�õ�����
    add dl, '0'                    ; ������ת��Ϊ�ַ�
    dec di
    mov [di], dl                   ; ���ַ����뻺��
    inc cx
    test ax, ax
    jnz convert_loop               ; ���̷�0��������10

    mov si, di                     ; ����siΪ����ַ����Ŀ�ʼ
    ret
num_to_str endp
end main
