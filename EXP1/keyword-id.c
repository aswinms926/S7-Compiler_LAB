#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define MAX 50

char keyword[10][10] = {"int","if","for","while","break","continue","auto","goto","return","void"};
char operators[] = "+-*/%=";
char separators[] = "(){},:;";

int iskeyword(char *word) {
    for (int i = 0; i < 10; i++) {
        if (strcmp(keyword[i], word) == 0)
            return 1;
    }
    return 0;
}

int isseparator(char ch) {
    return (strchr(separators, ch) != NULL);
}

int isoperator(char ch) {
    return (strchr(operators, ch) != NULL);
}

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (fp == NULL) {
        printf("Error opening file.\n");
        return 1;
    }

    char ch, buffer[MAX];
    int index = 0, isp = 0;

    while ((ch = fgetc(fp)) != EOF) {
        if (ch == '#') {
            printf("# : preprocessor directive\n");
            isp = 1;
            continue;
        }

        if (ch == ' ' || ch == '\t') {
            if (index > 0) {
                buffer[index] = '\0';
                if (isp)
                    printf("%s : preprocessor directive\n", buffer);
                else if (iskeyword(buffer))
                    printf("%s : keyword\n", buffer);
                else
                    printf("%s : identifier\n", buffer);
                index = 0;
            }
        }
        else if (ch == '\n') {
            if (index > 0) {
                buffer[index] = '\0';
                if (isp)
                    printf("%s : preprocessor directive\n", buffer);
                else if (iskeyword(buffer))
                    printf("%s : keyword\n", buffer);
                else
                    printf("%s : identifier\n", buffer);
                index = 0;
            }
            isp = 0; // reset preprocessor flag
        }
        else if (isseparator(ch)) {
            if (index > 0) {
                buffer[index] = '\0';
                if (iskeyword(buffer))
                    printf("%s : keyword\n", buffer);
                else
                    printf("%s : identifier\n", buffer);
                index = 0;
            }
            printf("%c : separator\n", ch);
        }
        else if (isoperator(ch)) {
            if (index > 0) {
                buffer[index] = '\0';
                if (iskeyword(buffer))
                    printf("%s : keyword\n", buffer);
                else
                    printf("%s : identifier\n", buffer);
                index = 0;
            }
            printf("%c : operator\n", ch);
        }
        else if (isalnum(ch) || ch == '_') {
            if (index < MAX - 1)
                buffer[index++] = ch;
        }
    }

    if (index > 0) {
        buffer[index] = '\0';
        if (isp)
            printf("%s : preprocessor directive\n", buffer);
        else if (iskeyword(buffer))
            printf("%s : keyword\n", buffer);
        else
            printf("%s : identifier\n", buffer);
    }

    fclose(fp);
    return 0;
}
