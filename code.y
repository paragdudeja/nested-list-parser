%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h> 
#include <stdbool.h>

int yylex();
int yyerror();
bool is_nested = false;
%}

%token NUMBER 
%token STRING
%token NEWLINE

%left ','
%left '[' ']'

%start Statement

/* Rule Section */
%%

Statement   : '[' Expression COMMA ']'  NEWLINE {
                    if(is_nested) {
                        printf("\nEntered statement is a VALID NESTED LIST example in Python\n\n");
                    }
                    else {
                        yyerror();
                    }
                    return 0;
                }
            ;

Expression  : Expression ',' Expression

            | '[' Expression COMMA ']' { is_nested = true; }

            | '[' ']' { is_nested = true; }

            | NUMBER

            | STRING

            ;

COMMA       : ','
            |
            ;

%%

//driver code
void main()
{
    printf("\nEnter statement to test for nested list in Python: ");
    yyparse();
}

int yyerror(char *msg)
{
   printf("\nNOT A VALID NESTED LIST example in Python...\n\n");
}
