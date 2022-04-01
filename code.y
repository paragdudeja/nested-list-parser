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
%token SINGLE_QUOTED_STRING
%token DOUBLE_QUOTED_STRING
%token NEWLINE

/* Associativity */
%left COMMA
%left OPENING_BRACKET CLOSING_BRACKET

%start Statement

/* Rule Section */
%%

Statement       : ListExpression NEWLINE {
                        if(is_nested) {
                            printf("\nEntered statement is a VALID EXAMPLE OF NESTED LIST in Python\n\n");
                        }
                        else {
                            yyerror();
                        }
                        return 0;
                    }
                ; // Starting statement


ListExpression  : OPENING_BRACKET Expression Tail CLOSING_BRACKET
                ; // General syntax of list in Python


Expression      : Expression COMMA Expression 
                | OPENING_BRACKET Expression Tail CLOSING_BRACKET { is_nested = true; }
                | OPENING_BRACKET CLOSING_BRACKET { is_nested = true; }
                | NUMBER
                | SINGLE_QUOTED_STRING
                | DOUBLE_QUOTED_STRING
                ; // Elements in the list


Tail            : COMMA
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
   printf("\nNOT A VALID EXAMPLE OF NESTED LIST in Python...\n\n");
}
