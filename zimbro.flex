import java_cup.runtime.Symbol;

%%
%public
%class AnalisadorLexico
%unicode
%cup
%line
%column

%{
    public int errosLexicos = 0;

    /* Cria um token para o CUP guardando linha e coluna (base 1). */
    private Symbol symbol(int tipo) {
        return new Symbol(tipo, yyline + 1, yycolumn + 1);
    }

    private Symbol symbol(int tipo, Object valor) {
        return new Symbol(tipo, yyline + 1, yycolumn + 1, valor);
    }

    private void erro(String msg) {
        errosLexicos++;
        System.err.println("ERRO LEXICO: " + msg
            + " na linha " + (yyline + 1)
            + ", coluna " + (yycolumn + 1));
    }
%}

%xstate COMENTARIO

/* DEFINICOES */

DIGITO      = [0-9]
LETRA       = [a-zA-Z]
IDENT       = ({LETRA}|_)({LETRA}|{DIGITO}|_)*
INTEIRO     = {DIGITO}+
REAL        = {DIGITO}+"."{DIGITO}+
IDENT_INVALIDO = {DIGITO}+({LETRA}|_|"°")({LETRA}|{DIGITO}|_|"°")*

%%

/* ESPACOS E COMENTARIOS */

[ \t\r\n]+              { /* Ignora espaços */ }

"#"[^\r\n]*             { /* Comentário de linha */ }

"'''"                   { yybegin(COMENTARIO); }

<COMENTARIO>"'''"       { yybegin(YYINITIAL); }
<COMENTARIO>[^]         { /* Ignora conteúdo */ }

/* PALAVRAS RESERVADAS - TIPOS */

"nat"                   { return symbol(sym.NAT); }
"int"                   { return symbol(sym.INT); }
"real"                  { return symbol(sym.REAL); }
"simbolo"               { return symbol(sym.SIMBOLO_TIPO); }
"texto"                 { return symbol(sym.TEXTO_TIPO); }
"binario"               { return symbol(sym.BINARIO); }

/* PALAVRAS RESERVADAS - COMANDOS */

"imprimir"              { return symbol(sym.IMPRIMIR); }
"ler"                   { return symbol(sym.LER); }
"se"                    { return symbol(sym.SE); }
"senao"                 { return symbol(sym.SENAO); }
"para"                  { return symbol(sym.PARA); }
"enquanto"              { return symbol(sym.ENQUANTO); }

/* VALORES BOOLEANOS */

"verdadeiro"            { return symbol(sym.VERDADEIRO); }
"falso"                 { return symbol(sym.FALSO); }

/* OPERADORES LOGICOS */

"&&"                    { return symbol(sym.E_LOGICO); }
"||"                    { return symbol(sym.OU_LOGICO); }
"!"                     { return symbol(sym.NAO_LOGICO); }

/* OPERADORES DE DESLOCAMENTO */

"<<"                    { return symbol(sym.DESLOCAMENTO_ESQUERDA); }
">>"                    { return symbol(sym.DESLOCAMENTO_DIREITA); }

/* OPERADORES ARITMETICOS */

"^^"                    { return symbol(sym.POTENCIACAO); }
"+"                     { return symbol(sym.SOMA); }
"-"                     { return symbol(sym.SUBTRACAO); }
"*"                     { return symbol(sym.MULTIPLICACAO); }
"/"                     { return symbol(sym.DIVISAO); }

/* OPERADORES RELACIONAIS */

">="                    { return symbol(sym.MAIOR_IGUAL); }
"<="                    { return symbol(sym.MENOR_IGUAL); }
"=="                    { return symbol(sym.IGUALDADE); }
"!="                    { return symbol(sym.DIFERENTE); }
">"                     { return symbol(sym.MAIOR); }
"<"                     { return symbol(sym.MENOR); }

/* ATRIBUICAO */

"="                     { return symbol(sym.ATRIBUICAO); }

/* DELIMITADORES */

";"                     { return symbol(sym.PONTO_VIRGULA); }
"("                     { return symbol(sym.ABRE_PARENTESES); }
")"                     { return symbol(sym.FECHA_PARENTESES); }
"["                     { return symbol(sym.ABRE_BLOCO); }
"]"                     { return symbol(sym.FECHA_BLOCO); }
","                     { return symbol(sym.VIRGULA); }

/* IDENTIFICADORES INVALIDOS
   Reporta o erro, mas devolve IDENTIFICADOR para o sintatico continuar
   sem gerar uma cascata de erros sintaticos. */

{IDENT_INVALIDO}        {
                            erro("Identificador nao pode comecar com numero: " + yytext());
                            return symbol(sym.IDENTIFICADOR, yytext());
                        }

/* NUMEROS */

{REAL}                  { return symbol(sym.NUMERO_REAL, yytext()); }
{INTEIRO}               { return symbol(sym.NUMERO_INTEIRO, yytext()); }

/* TEXTO E SIMBOLO */

\"([^\"\\\r\n]|\\.)*\"  { return symbol(sym.TEXTO, yytext()); }

\'([^\'\\\r\n]|\\.)\'   { return symbol(sym.SIMBOLO, yytext()); }

/* IDENTIFICADORES */

{IDENT}                 { return symbol(sym.IDENTIFICADOR, yytext()); }

/* ERRO LEXICO: caractere invalido e ignorado */

.                       { erro("caractere invalido '" + yytext() + "'"); }

/* FIM DE ARQUIVO DENTRO DE COMENTARIO */

<COMENTARIO><<EOF>>     {
                            errosLexicos++;
                            System.err.println("ERRO LEXICO: Comentario nao finalizado.");
                            return symbol(sym.EOF);
                        }
