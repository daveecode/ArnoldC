%language "c++"
%locations
%define api.value.type variant

%code top {
#include "implementation.hh"
#include <list>
}

%code provides {
int yylex(yy::parser::semantic_type* yylval, yy::parser::location_type* yylloc);
}

%token START, END, PRINT, IN, ERROR
%token DECLARE, DEFAULT, ASSIGN, ASSIGN_END
%token TRUE, FALSE
%token OP, PLUS, MINUS, MUL, DIV, MOD
%token EQUAL, GREATER, OR, AND
%token IF, ELSE, ENDIF, WHILE, DONE
%token FUNC, FUNC_END, ARG, NON_VOID, RETURN
%token CALL, CALL_TO_VAR

%token NUM, STRING, VAR

%%
start: START END
    {
        std::cout << "start -> program" << std::endl;
    }
;
