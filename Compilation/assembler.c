#include <stdio.h>

int main() {
    char ch = 'a';
    int i, j;

    for (i = 0; i < 2; i++) { // ���ѭ��������������2��
        for (j = 0; j < 13; j++) { // �ڲ�ѭ������ÿ�е��ַ���
            printf("%c", ch + j); // ��ӡ�ַ�
        }
        printf("\n"); // ÿ�н�������
        ch += 13; // �ƶ�����һ�е���ʼ��ĸ
    }

    return 0;
}
