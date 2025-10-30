%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int yylex();
void yyerror(const char *msg);
void change(char *str);
%}

%token WORD NL

%%
stmt : line NL
     ;

line : WORD { change(yytext); }
     | NL   { printf("\n"); }
     ;
%%

void change(char *str)
{
    for (int i = 0; str[i] != '\0'; i++)
    {
        if (islower(str[i]))
            printf("%c", toupper(str[i]));
        else if (isupper(str[i]))
            printf("%c", tolower(str[i]));
        else
            printf("%c", str[i]);
    }
    printf(" ");
}

void yyerror(const char *msg)
{
    printf("ERROR : %s\n", msg);
    exit(0);
}

int main()
{
    printf("Enter the string : ");
    yyparse();
    return 0;
}
