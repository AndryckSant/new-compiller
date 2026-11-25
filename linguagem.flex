
%%
%public
%class AnalisadorLexico
%unicode
%standalone
%line
%column

%{
    private void token(String nome) {
        System.out.println(nome);
    }

    private void token(String nome, String valor) {
        System.out.println(nome + ": " + valor);
    }
%}

%xstate COMENTARIO

/* DEFINICOES */

DIGITO      = [0-9]
LETRA       = [a-zA-Z]
IDENT       = ({LETRA}|_)({LETRA}|{DIGITO}|_)*
INTEIRO     = {DIGITO}+
REAL        = {DIGITO}+"."{DIGITO}+
IDENT_INVALIDO = {DIGITO}+({LETRA}|_|"\u00B0")({LETRA}|{DIGITO}|_|"\u00B0")*

%%

/* ESPACOS E COMENTARIOS */

[ \t\r\n]+              { /* Ignora espaços */ }

"#"[^\r\n]*             { /* Comentário de linha */ }

"'''"                   { yybegin(COMENTARIO); }

<COMENTARIO>"'''"       { yybegin(YYINITIAL); }
<COMENTARIO>[^]         { /* Ignora conteúdo */ }

/* PALAVRAS RESERVADAS - TIPOS */

"nat"                   { token("NAT"); }
"int"                   { token("INT"); }
"real"                  { token("REAL"); }
"simbolo"               { token("SIMBOLO"); }
"texto"                 { token("TEXTO_TIPO"); }
"binario"               { token("BINARIO"); }

/* PALAVRAS RESERVADAS - COMANDOS */

"imprimir"              { token("IMPRIMIR"); }
"ler"                   { token("LER"); }
"se"                    { token("SE"); }
"senao"                 { token("SENAO"); }
"para"                  { token("PARA"); }
"enquanto"              { token("ENQUANTO"); }

/* VALORES BOOLEANOS */

"verdadeiro"            { token("VERDADEIRO"); }
"falso"                 { token("FALSO"); }

/* OPERADORES LOGICOS */

"&&"                    { token("E_LOGICO"); }
"||"                    { token("OU_LOGICO"); }
"!"                     { token("NAO_LOGICO"); }

/* OPERADORES DE DESLOCAMENTO */

"<<"                    { token("DESLOCAMENTO_ESQUERDA"); }
">>"                    { token("DESLOCAMENTO_DIREITA"); }

/* OPERADORES ARITMETICOS */

"^^"                    { token("POTENCIACAO"); }
"+"                     { token("SOMA"); }
"-"                     { token("SUBTRACAO"); }
"*"                     { token("MULTIPLICACAO"); }
"/"                     { token("DIVISAO"); }

/* OPERADORES RELACIONAIS */

">="                    { token("MAIOR_IGUAL"); }
"<="                    { token("MENOR_IGUAL"); }
"=="                    { token("IGUALDADE"); }
"!="                    { token("DIFERENTE"); }
">"                     { token("MAIOR"); }
"<"                     { token("MENOR"); }

/* ATRIBUICAO */

"="                     { token("ATRIBUICAO"); }

/* DELIMITADORES */

";"                     { token("PONTO_VIRGULA"); }
"("                     { token("ABRE_PARENTESES"); }
")"                     { token("FECHA_PARENTESES"); }
"["                     { token("ABRE_BLOCO"); }
"]"                     { token("FECHA_BLOCO"); }
","                     { token("VIRGULA"); }

/* IDENTIFICADORES INVALIDOS */

{IDENT_INVALIDO} {
    System.out.println(
        "ERRO LEXICO: Identificador nao pode comecar com numero: "
        + yytext()
        + " na linha " + (yyline + 1)
        + ", coluna " + (yycolumn + 1)
    );
}
/* NUMEROS */
{REAL}                  { token("NUMERO_REAL", yytext()); }
{INTEIRO}               { token("NUMERO_INTEIRO", yytext()); }

/* TEXTO E SIMBOLO */

\"([^\"\\\r\n]|\\.)*\"  { token("TEXTO", yytext()); }

\'([^\'\\\r\n]|\\.)\'   { token("SIMBOLO", yytext()); }

/* IDENTIFICADORES */

{IDENT}                 { token("IDENTIFICADOR", yytext()); }

/* ERRO LEXICO */

.                       {
                            System.out.println(
                                "ERRO LEXICO: " + yytext()
                                + " na linha " + (yyline + 1)
                                + ", coluna " + (yycolumn + 1)
                            );
                        }

/* FIM DE ARQUIVO DENTRO DE COMENTARIO */

<COMENTARIO><<EOF>> {
    System.out.println(
        "ERRO: Comentario nao finalizado."
    );
    return YYEOF;
}
