%{
#include<stdio.h>
#include<stdlib.h>
%}

%token DIGIT ID NL
%left '+' '-'
%left '*' '/'

%%

stmt : exp NL { printf("valid expression\n"); exit(0); };

exp  : exp '+' exp
     | exp '-' exp
     | exp '*' exp
     | exp '/' exp
     | '(' exp ')'
     | DIGIT
     | ID
     ;

%%

int yyerror(const char *msg) {
    printf("invalid string\n");
    exit(0);
}

int main() {
    printf("Enter the input : ");
    yyparse();
    return 0;
}
