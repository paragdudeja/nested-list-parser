%{
/* Definition section */
#include<stdio.h>
#include "y.tab.h"
extern int yylval;
%}

/* Rule Section */
%%
[-+]?[0-9]+[.]?[0-9]* { 
    return NUMBER;
} // Regex for integer/float values

[\t ' '] ; // Eliminates whitespaces

["'][a-zA-Z0-9 ]*["'] {
    return STRING;
}

[\n] {
    return NEWLINE;
} // New Line character

. return yytext[0];

%%

int yywrap()
{
    return 1;
}
