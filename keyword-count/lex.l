%{
#include <stdio.h>
#include "y.tab.h"

int intcount = 0;
int ifcount = 0;
int rcount = 0;
int elcount = 0;
%}

%%
"int"     { intcount++; return KEYWORD; }
"if"      { ifcount++; return KEYWORD; }
"return"  { rcount++; return KEYWORD; }
"else"    { elcount++; return KEYWORD; }

[ \t]     ;    /* ignore spaces and tabs */
\n        { return NL; }
.         { return yytext[0]; }
%%

int yywrap() { return 1; }
