%option noyywrap c++ yylineno

%{
#include <iostream>
#include <fstream>
%}

WS [ \t\n]
COMMENT [--][^\n]*
VARIABLE [a-zA-Z_][a-zA-Z0-9_]*
STRING_LITERAL ["][ \t\n():+*/%<>=_#-?!.'a-zA-Z0-9]*["]
NUMBER_LITERAL [0-9]+

%%

"IT'S SHOWTIME"    std::cout << "kulcsszo: " << YYText() << " - program kezdete" << std::endl;
"YOU HAVE BEEN TERMINATED"    std::cout << "kulcsszo: " << YYText() << " - program vege" << std::endl;
"TALK TO THE HAND"   std::cout << "print kulcsszo: " << YYText() << std::endl;
"I WANT TO ASK YOU A BUNCH OF QUESTIONS AND I WANT TO HAVE THEM ANSWERED IMMEDIATELY"   std::cout << "valtozo bekeres: " << YYText() << std::endl;
"HEY CHRISTMAS TREE"   std::cout << "kulcsszo: " << YYText() << " - valtozo deklaralas" << std::endl;
"YOU SET US UP"   std::cout << "kezdeti ertekadas: " << YYText() << std::endl;
"@I LIED"    std::cout << "hamis: " << YYText() << std::endl;
"@NO PROBLEMO"   std::cout << "igaz: " << YYText() << std::endl;
"GET TO THE CHOPPER"   std::cout << "ertekadas: " << YYText() << std::endl;
"HERE IS MY INVITATION"  std::cout << "operandusok: " << YYText() << std::endl;
"ENOUGH TALK"    std::cout << "ertekadas vege: " << YYText() << std::endl;
"GET UP"    std::cout << "plusz: " << YYText() << std::endl;
"GET DOWN"    std::cout << "minusz: " << YYText() << std::endl;
"YOU'RE FIRED"  std::cout << "szorzas: " << YYText() << std::endl;
"HE HAD TO SPLIT"   std::cout << "osztas: " << YYText() << std::endl;
"I LET HIM GO"   std::cout << "modulo: " << YYText() << std::endl;
"YOU ARE NOT YOU YOU ARE ME"   std::cout << "==: " << YYText() << std::endl;
"LET OFF SOME STEAM BENNET"    std::cout << ">: " << YYText() << std::endl;
"CONSIDER THAT A DIVORCE"     std::cout << "or kulcsszo: " << YYText() << std::endl;
"KNOCK KNOCK"    std::cout << "and kulcsszo: " << YYText() << std::endl;
"BECAUSE I'M GOING TO SAY PLEASE"    std::cout << "if kulcsszo: " << YYText() << std::endl;
"BULLSHIT"   std::cout << "else kulcsszo: " << YYText() << std::endl;
"YOU HAVE NO RESPECT FOR LOGIC"   std::cout << "if vege kulcsszo: " << YYText() << std::endl;
"STICK AROUND"   std::cout << "while ciklus kezdete: " << YYText() << std::endl;
"CHILL"   std::cout << "while ciklus vege: " << YYText() << std::endl;
"LISTEN TO ME VERY CAREFULLY"   std::cout << "metodus deklaralas: " << YYText() << std::endl;
"HASTA LA VISTA, BABY"   std::cout << "metodus vege: " << YYText() << std::endl;
"I NEED YOUR CLOTHES YOUR BOOTS AND YOUR MOTORCYCLE"   std::cout << "metodus argumentum: " << YYText() << std::endl;
"GIVE THESE PEOPLE AIR"   std::cout << "non-void metodus: " << YYText() << std::endl;
"I'LL BE BACK"   std::cout << "return kulcsszo: " << YYText() << std::endl;
"DO IT NOW"   std::cout << "metodus hivasa: " << YYText() << std::endl;
"GET YOUR ASS TO MARS"   std::cout << "metodus eredmenye valtozoba: " << YYText() << std::endl;
"WHAT THE FUCK DID I DO WRONG"   std::cout << "Hiba kulcsszo: " << YYText() << std::endl;
{WS}    std::cout << "whitespace: " << YYText() << std::endl;
{COMMENT} std::cout << "megjegyzes: " << YYText() << std::endl;
{NUMBER_LITERAL}    std::cout << "szam literal: " << YYText() << std::endl;
{STRING_LITERAL}    std::cout << "string literal: " << YYText() << std::endl;
{VARIABLE}   std::cout << "valtozo: " << YYText() << std::endl;
.       {
            std::cerr << lineno() << ": Lexikalis hiba." << YYText() << std::endl;
            exit(1);
        }

%%