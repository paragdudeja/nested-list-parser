%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h> 
#include <stdbool.h>

int yylex();
int yyerror();
bool is_nested = false; // Variable to track whether nested list is found
%}
/* Tokens */
%token NUMBER
%token STRING
%token NEWLINE


/* Associativity */
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
                } // Start Statement
            ;

Expression  : Expression ',' Expression 

            | '[' Expression COMMA ']' { is_nested = true; }

            | '[' ']' { is_nested = true; }

            | NUMBER

            | STRING

            ; // Elements in the list

COMMA       : ','
            |
            ; // Optional comma after the last item in list

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
