#include <stdio.h>

int main() {
    char ch = 'a';
    int i, j;

    for (i = 0; i < 2; i++) { // 外层循环控制行数，共2行
        for (j = 0; j < 13; j++) { // 内层循环控制每行的字符数
            printf("%c", ch + j); // 打印字符
        }
        printf("\n"); // 每行结束后换行
        ch += 13; // 移动到下一行的起始字母
    }

    return 0;
}
