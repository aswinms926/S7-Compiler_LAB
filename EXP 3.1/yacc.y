%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    int yylex();
    void yyerror(const char *msg);   // ✅ added semicolon and fixed definition syntax
%}

%token DIGIT NL
%left '+' '-'
%left '*' '/'

%%
stmt : exp NL               { printf("Value is : %d\n", $1); exit(0); }
     ;

exp  : exp '+' exp           { $$ = $1 + $3; }
     | exp '-' exp           { $$ = $1 - $3; }
     | exp '*' exp           { $$ = $1 * $3; }
     | exp '/' exp           {
                                if ($3 == 0) {
                                    printf("Division by zero not possible\n");
                                    exit(1);        // ✅ exit if divide by zero
                                }
                                $$ = $1 / $3;
                             }
     | DIGIT                 { $$ = $1; }
     ;
%%

void yyerror(const char *msg)
{
    printf("Error: %s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter the expression : ");
    yyparse();
    return 0;
}
