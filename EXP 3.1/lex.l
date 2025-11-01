%{
    #include<stdio.h>
    #include<stdlib.h>     // ✅ needed for atoi()
    #include"y.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return DIGIT; }

[ \t]       { /* ignore spaces and tabs */ }

\n          { return NL; }

.           { return yytext[0]; }
%%

int yywrap()
{
    return 1;
}
