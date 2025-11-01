%{
#include<stdio.h>
#include"y.tab.h"
%}

%%
[0-9]+                  { return DIGIT; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }
[ \t]+                  { /* ignore whitespace */ }
\n                      { return NL; }
.                       { return yytext[0]; }
%%

int yywrap() { return 1; }
