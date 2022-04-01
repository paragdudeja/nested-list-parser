%{
/* Definition section */
#include<stdio.h>
#include "y.tab.h"
%}

/* Rule Section */
%%
[-+]?[0-9]+[.]?[0-9]* { 
    return NUMBER;
} // Regex for integer/float values

[\t ] ; // Eliminates whitespaces

["][a-zA-Z0-9!@#$%^&*(),./<>?; ]*["] {
    return DOUBLE_QUOTED_STRING;
} // String using double quotes

['][a-zA-Z0-9!@#$%^&*(),./<>?; ]*['] {
    return SINGLE_QUOTED_STRING;
} // String using single quotes

"[" {
    return OPENING_BRACKET;
} // Opening Square Bracket

"]" {
    return CLOSING_BRACKET;
} //  Closing Square Bracket

"," {
    return COMMA;
} // Comma character

[\n] {
    return NEWLINE;
} // New Line character

. return yytext[0];

%%

int yywrap()
{
    return 1;
}
