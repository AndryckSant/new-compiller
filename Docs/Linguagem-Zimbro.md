# Especificacao Formal da Linguagem Zimbro

Zimbro utiliza blocos delimitados por colchetes. Um programa inteiro e
considerado um bloco de comandos:

```text
[
    # comandos do programa
]
```

Os comandos terminam, em geral, com ponto e virgula (`;`). Os comandos `se`,
`senao`, `para` e `enquanto` usam blocos delimitados por `[ ]`, enquanto suas
condicoes sao escritas entre parenteses.

## Tipos de dados

| Tipo | Descricao |
|---|---|
| `nat` | Numero natural |
| `int` | Numero inteiro |
| `real` | Numero real |
| `simbolo` | Um unico caractere |
| `texto` | Sequencia de caracteres |
| `binario` | Valor logico |

Os valores logicos sao representados pelas palavras reservadas `verdadeiro`
e `falso`.

## Palavras reservadas

| Palavra reservada | Funcao |
|---|---|
| `imprimir` | Escreve uma expressao no terminal |
| `ler` | Le um valor do teclado e o atribui a uma variavel |
| `se` | Executa um bloco quando a condicao for verdadeira |
| `senao` | Executa um bloco quando a condicao do `se` nao for atendida |
| `para` | Executa um bloco conforme inicializacao, condicao e atualizacao |
| `enquanto` | Executa um bloco enquanto a condicao permanecer verdadeira |
| `verdadeiro` | Valor logico verdadeiro |
| `falso` | Valor logico falso |
| `nat`, `int`, `real`, `simbolo`, `texto`, `binario` | Tipos de dados |

## Identificadores

Um identificador comeca por uma letra ou pelo caractere `_`. Os caracteres
seguintes podem ser letras, digitos ou `_`. Identificadores sao sensiveis a
maiusculas e minusculas.

Exemplos validos:

```text
idade
idade2
_valor
valor_
NomeCompleto
```

Nao sao permitidos identificadores que comecem por digito.

```text
IDENTIFICADOR ::= (LETRA | "_") (LETRA | DIGITO | "_")*
IDENT_INVALIDO ::= DIGITO+ (LETRA | "_" | "°") (LETRA | DIGITO | "_" | "°")*
```

O identificador invalido recebe tratamento lexico especial: gera uma mensagem
de erro, mas o lexema e entregue ao analisador sintatico como identificador
para evitar uma cascata desnecessaria de erros sintaticos.

## Numeros

- Natural: `0`, `10`, `2026`;
- Inteiro: numero natural positivo ou negativo, como `10` ou `-10`;
- Real: parte inteira e parte decimal separadas por ponto, como `3.14`
  ou `-1.75`.

```text
NUMERO_NATURAL ::= DIGITO+
NUMERO_INTEIRO ::= "-"? DIGITO+
NUMERO_REAL ::= DIGITO+ "." DIGITO+
```

## Texto e simbolo

Um texto e escrito entre aspas duplas:

```text
"Zimbro"
"Maior de idade"
```

Um simbolo e escrito entre aspas simples e contem exatamente um caractere:

```text
'Z'
'A'
```

## Operadores

### Operadores aritmeticos

| Operador | Operacao |
|---|---|
| `+` | Adicao |
| `-` | Subtracao ou menos unario |
| `*` | Multiplicacao |
| `/` | Divisao |
| `^^` | Potenciacao |

### Operadores relacionais

| Operador | Operacao |
|---|---|
| `>` | Maior que |
| `>=` | Maior ou igual a |
| `<` | Menor que |
| `<=` | Menor ou igual a |
| `==` | Igualdade |
| `!=` | Diferente |

### Operadores logicos

| Operador | Operacao |
|---|---|
| `&&` | E logico |
| `\|\|` | Ou logico |
| `!` | Negacao logica |

### Operadores de deslocamento de bits

| Operador | Operacao |
|---|---|
| `<<` | Deslocamento para a esquerda |
| `>>` | Deslocamento para a direita |

### Operador de atribuicao

O sinal `=` atribui o resultado de uma expressao a um identificador.

## Precedencia das expressões

Da menor para a maior precedencia:

1. Ou logico (`||`);
2. E logico (`&&`);
3. Negacao logica (`!`);
4. Operadores relacionais;
5. Deslocamento de bits (`<<` e `>>`);
6. Adicao e subtracao (`+` e `-`);
7. Multiplicacao e divisao (`*` e `/`);
8. Menos unario;
9. Potenciacao (`^^`).

Os operadores relacionais nao sao associativos. Por exemplo, `a < b < c`
nao deve ser utilizado como uma cadeia de comparacoes.

## Delimitadores

| Delimitador | Uso |
|---|---|
| `[` | Abre um bloco de comandos |
| `]` | Fecha um bloco de comandos |
| `(` | Abre uma lista de parametros ou uma expressao agrupada |
| `)` | Fecha uma lista de parametros ou uma expressao agrupada |
| `,` | Separa identificadores em uma declaracao |
| `;` | Termina comandos e separa as partes do `para` |

## Comentarios

- Comentario de linha: inicia com `#` e termina no fim da linha.
- Comentario de varias linhas: inicia e termina com `'''`.

```text
# Comentario de linha

'''
Comentario
de varias linhas
'''
```

## Declaracao de variaveis

Uma declaracao pode criar um ou mais identificadores do mesmo tipo:

```text
nat idade, ano;
int temperatura;
real altura, largura;
texto nome;
simbolo inicial;
binario ativo;
```

Uma variavel tambem pode ser declarada com um valor inicial:

```text
nat idade = 21;
int temperatura = -5;
real altura = 1.75;
texto nome = "Zimbro";
simbolo inicial = 'Z';
binario ativo = verdadeiro;
```

## Comandos

### Atribuicao

```text
identificador = expressao;
```

### Entrada

```text
ler(identificador);
```

### Saida

```text
imprimir(expressao);
```

### Comando `se`

```text
se (expressao) [
    # comandos executados quando expressao for verdadeira
] senao [
    # comandos executados quando expressao for falsa
]
```

A parte `senao` e opcional.

### Comando `enquanto`

```text
enquanto (expressao) [
    # comandos repetidos enquanto expressao for verdadeira
]
```

### Comando `para`

```text
para (inicializacao; expressao; atualizacao) [
    # comandos repetidos
]
```

A inicializacao pode declarar uma variavel com tipo ou apenas atribuir um valor:

```text
para (int i = 0; i < 10; i = i + 1) [
    imprimir(i);
]
```

A atualizacao deve ser uma atribuicao a um identificador.

## Exemplo completo

```text
# Programa principal

[
    nat idade;
    idade = 21;

    se (idade >= 18) [
        imprimir("Maior de idade");
    ] senao [
        imprimir("Menor de idade");
    ]
]
```

## Notacao BNF

```bnf
<programa> ::= <bloco comandos>

<bloco comandos> ::= <inicio bloco> <comandos> <fim bloco>

<inicio bloco> ::= [

<fim bloco> ::= ]

<comando> ::= <comando ler>
            | <comando imprimir>
            | <declaracao de variavel>
            | <comando se>
            | <comando para>
            | <comando enquanto>
            | <atribuicao de variavel>

<comandos> ::= <comando>
             | <comando> <comandos>

<comando ler> ::= ler ( <identificador> ) ;

<comando imprimir> ::= imprimir ( <expressao> ) ;

<declaracao de variavel> ::= <tipo> <identificador> { , <identificador> } ;
                           | <tipo> <identificador> = <expressao> ;

<atribuicao de variavel> ::= <identificador> = <expressao> ;

<comando se> ::= se ( <expressao> ) <bloco comandos>
               | se ( <expressao> ) <bloco comandos> senao <bloco comandos>

<comando enquanto> ::= enquanto ( <expressao> ) <bloco comandos>

<comando para> ::= para ( <inicializacao> ; <expressao> ; <atualizacao> )
                   <bloco comandos>

<inicializacao> ::= <tipo> <identificador> = <expressao>
                  | <identificador> = <expressao>

<atualizacao> ::= <identificador> = <expressao>

<expressao> ::= <expressao primaria>
              | <expressao aritmetica>
              | <expressao relacional>
              | <expressao logica>
              | <operacao de bits>

<expressao primaria> ::= ( <expressao> )
                       | <numero>
                       | <identificador>
                       | <valor booleano>
                       | <texto>
                       | <simbolo>

<expressao aritmetica> ::= <expressao aditiva>

<expressao aditiva> ::= <expressao aditiva> + <expressao multiplicativa>
                      | <expressao aditiva> - <expressao multiplicativa>
                      | <expressao multiplicativa>

<expressao multiplicativa> ::= <expressao multiplicativa> * <expressao unaria>
                             | <expressao multiplicativa> / <expressao unaria>
                             | <expressao unaria>

<expressao unaria> ::= - <expressao unaria>
                     | <expressao potencia>

<expressao potencia> ::= <expressao potencia> ^^ <expressao primaria>
                       | <expressao primaria>

<operador aritmetico> ::= + | - | * | / | ^^

<expressao relacional> ::= <expressao aritmetica>
                          <operador relacional>
                          <expressao aritmetica>

<operador relacional> ::= > | >= | < | <= | == | !=

<expressao logica> ::= <expressao relacional>
                     | <expressao logica> <operador logico> <expressao logica>
                     | ! <expressao logica>
                     | <valor booleano>

<operador logico> ::= && | ||

<operacao de bits> ::= <expressao> << <expressao>
                     | <expressao> >> <expressao>

<identificador> ::= <letra>
                  | <letra> <identificador>
                  | <identificador> <digito>
                  | _ <identificador>
                  | <identificador> _

<tipo> ::= nat | int | real | simbolo | texto | binario

<digito> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

<letra> ::= a | b | c | ... | z | A | B | C | ... | Z

<numero> ::= <numero natural>
           | <numero inteiro>
           | <numero real>

<numero natural> ::= <digito>
                   | <digito> <numero natural>

<numero inteiro> ::= <numero natural>
                   | - <numero natural>

<numero real> ::= <numero natural> . <numero natural>
                | - <numero natural> . <numero natural>

<valor booleano> ::= verdadeiro | falso

<texto> ::= " <caracteres> "

<simbolo> ::= ' <caractere> '

<caracteres> ::= <caractere>
               | <caractere> <caracteres>

<caractere> ::= <letra>
              | <digito>
              | <espaco>
              | <caractere especial>

<espaco> ::= " "

<caractere especial> ::= ! | @ | # | $ | % | & | ...
```
