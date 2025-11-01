%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int yylex();
void yyerror(const char *msg);
%}

%token ID NL
%%
stmt : exp NL { printf("valid ID\n"); exit(0); }
     ;
exp  : ID
     ;
%%
void yyerror(const char *msg)
{
    printf("invalid ID\n");
    exit(0);
}

int main()
{
    printf("Enter the string : ");
    yyparse();
    return 0;
}
