%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *msg);

extern int intcount, ifcount, rcount, elcount;
%}

%token KEYWORD NL

%%
stmt : line NL
     ;

line : KEYWORD
     | NL
     ;
%%

void yyerror(const char *msg)
{
    printf("ERROR : %s\n", msg);
    exit(0);
}

int main()
{
    printf("Enter the string:\n");
    yyparse();

    printf("\nKeyword   Count\n");
    printf("----------------\n");
    printf("int       %d\n", intcount);
    printf("if        %d\n", ifcount);
    printf("return    %d\n", rcount);
    printf("else      %d\n", elcount);
    printf("----------------\n");
    printf("Total     %d\n", intcount + ifcount + rcount + elcount);

    return 0;
}
