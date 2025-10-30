%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[a-zA-Z]+   { return WORD; }
[ \t]       { }      /* ignore spaces and tabs */
\n          { return NL; }
.           { return yytext[0]; }
%%

int yywrap() { return 1; }
