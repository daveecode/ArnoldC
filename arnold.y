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

%token START END PRINT IN ERROR
%token DECLARE DEFAULT ASSIGN ASSIGN_END
%token TRUE FALSE
%token OP PLUS MINUS MUL DIV MOD
%token EQUAL GREATER OR AND
%token IF ELSE ENDIF WHILE DONE
%token FUNC FUNC_END ARG NON_VOID RETURN
%token CALL CALL_TO_VAR

%token <std::string> VAR
%token <std::string> NUM
%token <std::string> STRING

%type <expression*> variable
%type <expression*> operand
%type <std::list<expression*>* > operands
%type <instruction*> statement
%type <std::list<instruction*>* > statements

%%
start:
    START statements END func
    {
        type_check_commands($2);
        if(current_mode == compiler) {
            generate_code($2);
        } else {
            execute_commands($2);
        }
        delete_commands($2);
    }
;

statements:
    {
        //std::cout << "empty statements" << std::endl;
        $$ = new std::list<instruction*>();
    }
|
    statements statement
    {
        //std::cout << "statements -> statements statement" << std::endl;
        $1->push_back($2);
        $$ = $1;
    }
;

statement:
    PRINT variable
    {
        $$ = new write_instruction(@1.begin.line, $2);
    }
|
    DECLARE VAR DEFAULT variable
    {
        std::cout << $2 << "...variable type: " << $4->get_type() << std::endl;
        symbol(@1.begin.line, $2, $4->get_type()).declare();
        $$ = new assign_instruction(@3.begin.line, $2, $4);
    }
|
    ASSIGN VAR operands ASSIGN_END
    {
        //std::cout << "statement -> ASSIGN VAR OP variable operands ASSIGN_END" << std::endl;
        //std::list<expression*>::iterator it;
        /* for(it = $3->begin(); it != $3->end(); ++it) {
            std::cout << "listaban: ";
            std::cout << (*it)->get_value() << std::endl;
        } */
        //symbol(@2.begin.line, $2, $3->back()->get_type()).declare();
        std::cout << "last: " << $3->back()->get_value() << std::endl;

        $$ = new assign_instruction(@1.begin.line, $2, $3->back());
    }
|
    IF variable statements ENDIF
    {
        //std::cout << "statement -> IF variable statements ENDIF" << std::endl;
        $$ = new if_instruction(@1.begin.line, $2, $3, 0);
    }
|
    IF variable statements ELSE statements ENDIF
    {
        //std::cout << "statement -> IF variable statements ELSE statements ENDIF" << std::endl;
        $$ = new if_instruction(@1.begin.line, $2, $3, $5);
    }
|
    WHILE variable statements DONE
    {
        //std::cout << "statement -> WHILE variable statements DONE" << std::endl;
        $$ = new while_instruction(@1.begin.line, $2, $3);
    }
|
    RETURN
    {
        std::cout << "statement -> RETURN" << std::endl;
    }
|
    RETURN variable
    {
        std::cout << "statement -> RETURN variable" << std::endl;
    }
|
    CALL VAR args
    {
        std::cout << "statement -> CALL VAR args" << std::endl;
    }
|
    CALL_TO_VAR VAR CALL VAR params
    {
        std::cout << "statement -> CALL_TO_VAR VAR CALL VAR args" << std::endl;
    }
;

func:
    {
        std::cout << "no function definitions" << std::endl;
    }
|
    FUNC VAR args type statements FUNC_END
    {
        //std::cout << "func -> FUNC VAR args type statements FUNC_END" << std::endl;
        //itt inicializaljuk a fuggvenyt
    }
;

args:
    {
        std::cout << "no more args" << std::endl;
        //$$ = new std::list<expression*>();

    }
|
    args ARG VAR
    {
        /* $$ = new id_expression($3);
        $1->push_back($$);
        $$ = $1; */
        std::cout << "args -> args VAR" << std::endl;
    }
;

params:
    {
        std::cout << "no more params" << std::endl;
    }
|
    params variable
    {
        std::cout << "params -> params variable" << std::endl;
    }
;

type:
    {
        std::cout << "void type" << std::endl;
        //$$ = "void"
    }
|
    NON_VOID
    {
        std::cout << "type -> NON_VOID" << std::endl;
        //$$ = "non_void"
    }
;

operands:
    {
        //std::cout << "operands -> empty" << std::endl;
        $$ = new std::list<expression*>();
    }
|
    operands operand
    {
        $1->push_back($2);
        $$ = $1;
    }
;

operand:
    OP variable
    {
        //std::cout << "eljut: HERE IS MY INVITATION" << std::endl;
        last = $2;
        //std::cout << "ketto kozt: " << $2->get_value() << std::endl;
        $$ = last;
        //std::cout << "after HERE IS MY INVITATION: " << $$->get_value() << std::endl;
    }
|
    PLUS variable
    {
        //std::cout << "last: " << last->get_value() << std::endl;
        $$ = new op_expression(@1.begin.line, "+", last, $2);
        last = $$;
        //std::cout << "operand -> PLUS variable: " << $$->get_value() << std::endl;
    }
|
    MINUS variable
    {
        //std::cout << "operand -> MINUS variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "-", last, $2);
        last = $$;
    }
|
    MUL variable
    {
        $$ = new op_expression(@1.begin.line, "*", last, $2);
        last = $$;
        //std::cout << "operand -> MUL variable" << $$->get_value() << std::endl;
    }
|
    DIV variable
    {
        //std::cout << "operand -> DIV variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "/", last, $2);
        last = $$;
    }
|
    MOD variable
    {
        //std::cout << "operand -> MOD variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "%", last, $2);
        last = $$;
    }
|
    EQUAL variable
    {
        //std::cout << "operand -> EQUAL variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "=", last, $2);
        last = $$;
    }
|
    GREATER variable
    {
        //std::cout << "operand -> GREATER variable" << std::endl;
        $$ = new op_expression(@1.begin.line, ">", last, $2);
        last = $$;
    }
|
    OR variable
    {
        //std::cout << "operand -> OR variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "or", last, $2);
        last = $$;
    }
|
    AND variable
    {
        //std::cout << "operand -> AND variable" << std::endl;
        $$ = new op_expression(@1.begin.line, "and", last, $2);
        last = $$;
    }
;

variable:
    NUM
    {
        $$ = new number_expression($1);
    }
|
    TRUE
    {
        $$ = new boolean_expression(true);
    }
|
    FALSE
    {
        $$ = new boolean_expression(false);
    }
|
    VAR
    {
        $$ = new id_expression(@1.begin.line, $1);
    }
|
    STRING
    {
        std::cout << "variable -> STRING" << std::endl;
        //$$ = new string_expression($1);
    }
;
